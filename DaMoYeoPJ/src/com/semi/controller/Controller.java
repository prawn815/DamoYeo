package com.semi.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.about.dao.InfoBoardDao;
import com.about.dto.BikeDto;
import com.about.dto.InfoBoardDto;
import com.cal.dao.CalorieDao;
import com.cal.dao.Util;
import com.cal.dto.CalorieDto;
import com.cal.dto.DiaryDto;
import com.cal.dto.InbodyDto;
import com.login.dao.LoginDao;
import com.login.dto.LoginDto;
import com.post.dao.*;
import com.post.dto.*;
import com.product.dao.BasketDao;
import com.product.dao.ProductDao;
import com.product.dao.ReviewDao;
import com.product.dao.SaleorderDao;
import com.product.dto.BasketDto;
import com.product.dto.ProductDto;
import com.product.dto.ReviewDto;
import com.product.dto.SaleorderDto;

import org.json.simple.JSONObject;

@WebServlet("/controller.do")
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Controller() {
        //super();
    }
    
    protected void getMsg(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		HttpSession session = request.getSession();
		LoginDto testdto=(LoginDto)session.getAttribute("dto");
		
		String testid = null;
		if(testdto != null) {
			testid = testdto.getMyid();
		}

		String command = request.getParameter("command");
		System.out.println("[" + command + "]");
		
		LoginDao dao = new LoginDao();
		
		boardDao boarddao = new boardDaoImpl();
    	ansDao ansdao = new ansDaoImpl();
    	choiceDao choicedao = new choiceDaoImpl();
    	
    	CalorieDao caldao = new CalorieDao();
		Calendar cal = Calendar.getInstance();
		
		ProductDao pdao = new ProductDao();
		BasketDao bdao = new BasketDao();
		SaleorderDao sdao = new SaleorderDao();
		ReviewDao rdao = new ReviewDao();
		
		InfoBoardDao infodao = new InfoBoardDao();
		
		//------------------------------------------------------------------------로그인 및 회원
		
		if(command.equals("index")) {
			dispatch(request, response, "index1.jsp");
		}
		
		else if(command.equals("contact")) {
			dispatch(request, response, "contact.jsp");
		}
		
		else if(command.equals("about")) {
			dispatch(request, response, "controller.do?command=selectINFOBOARD&page=1&boardno=2");
		}
		
		else if(command.equals("post")) {
			dispatch(request, response, "post.jsp");
		}
		
		else if(command.equals("kcal")) {
			dispatch(request, response, "kcal.jsp");
		}
		
		else if(command.equals("adminpage")) {
			List<LoginDto> userlist = dao.selectAll();
			List<SaleorderDto> userorder = sdao.selectAdmin();
			request.setAttribute("userlist", userlist);	
			request.setAttribute("userorder", userorder);
			dispatch(request, response, "admin.jsp");
		}
		
		else if(command.equals("loginpage")) {
			dispatch(request, response, "login.jsp");
		}
		
		else if(command.equals("userpage")) {
			dispatch(request, response, "user.jsp");
		}
		// 기본 페이지 컨트롤러

		else if (command.equals("log")) {
			response.sendRedirect("login.jsp");
		}
		
		else if (command.equals("logfail")) {
			response.sendRedirect("userinfor.jsp");
		} 
		
		else if (command.equals("userinforupdate")) {
			response.sendRedirect("userinformodify.jsp");
		} 
		
		else if (command.equals("updateuser")) {
			response.sendRedirect("user.jsp");
		}
		
		else if (command.equals("login")) {

			String myid = request.getParameter("id");
			String mypw = request.getParameter("pw");

			if (myid == null || myid == "") {
				jsResponse(response, "controller.do?command=log", "아이디를 입력해주세요.");
			} 
			else if (mypw == null || mypw == "") {
				jsResponse(response, "controller.do?command=log", "비밀번호를 입력해주세요.");
			} 
			else {

				LoginDto dto = dao.login(myid, mypw);
				System.out.println(myid + "/" + mypw);

				try {
					if (dto.getMyid().equals(myid) && dto.getMypw().equals(mypw)) {
						session.setAttribute("dto", dto);
						session.setAttribute("username", dto.getMyid());
						session.setMaxInactiveInterval(60 * 60);

						if (dto.getMyrole().equals("ADMIN")) {
							dispatch(request, response, "controller.do?command=adminpage");

						} 
						else if (dto.getMyrole().equals("USER")) {
							response.sendRedirect("user.jsp");
						}
					}

				} catch (Exception e) {
				
						jsResponse(response, "controller.do?command=log", "아이디 또는 비밀번호가 틀립니다.");				
					
				}

				// }
			}

		} 
		
		else if (command.equals("userinfor")) {

			try {
				String id = request.getParameter("userid");
				String pw = request.getParameter("userpw");
				String name = request.getParameter("username");
				String gender = request.getParameter("usergender");
				int birthday = Integer.parseInt(request.getParameter("userbirthday"));
				String addr = request.getParameter("useraddr");
				String phone = request.getParameter("userphone");
				String email = request.getParameter("useremail");

				System.out.println(id);
				System.out.println(pw);
				System.out.println(name);
				System.out.println(gender);
				System.out.println(birthday);
				System.out.println(addr);
				System.out.println(phone);
				System.out.println(email);

				LoginDto dto = new LoginDto(id, pw, name, gender, birthday, addr, phone, email);

				int res = dao.insert(dto);

				if (res > 0) {
					jsResponse(response, "controller.do?command=log", dto.getMyname() + "님 회원가입을 축하드립니다!!");
				} 
				else {
					jsResponse(response, "controller.do?command=logfail", "회원가입 실패!!");
				}

			} catch (Exception e) {
				e.printStackTrace();
				String id = request.getParameter("userid");
				String pw = request.getParameter("userpw");
				String name = request.getParameter("username");
				String gender = request.getParameter("usergender");
				int birthday = Integer.parseInt(request.getParameter("userbirthday"));
				String addr = request.getParameter("useraddr");
				String phone = request.getParameter("userphone");
				String email = request.getParameter("useremail");
				
				System.out.println(id);
				System.out.println(pw);
				System.out.println(name);
				System.out.println(gender);
				System.out.println(birthday);
				System.out.println(addr);
				System.out.println(phone);
				System.out.println(email);
				
				
				LoginDto dto = new LoginDto(id, pw, name, gender, birthday, addr, phone, email);
				if(dto.getMyemail().equals(email)) {
					jsResponse(response, "controller.do?command=logfail", "중복된 이메일입니다.");
				}else if(dto.getMyphone().equals(phone)) {
					jsResponse(response, "controller.do?command=logfail", "중복된 전화번호입니다.");
				}
				jsResponse(response, "controller.do?command=logfail", "중복된 이메일과 전화번호 입니다.");
			}
		}
		
		else if (command.equals("idchk")) {

			try {

				String idchk = request.getParameter("idchk");
				System.out.println(idchk);
				LoginDto dto = dao.idchk(idchk);
				

				if (!dto.getMyid().equals(idchk)) {

					request.setAttribute("idchk", idchk);
					session.setMaxInactiveInterval(60*1);
					PrintWriter out = response.getWriter();
					out.print("<script type='text/javascript'>" + "alert('사용가능한 아이디 입니다.');" + "self.close();" + "</script>");

				} 
				else {
					PrintWriter out = response.getWriter();
					out.print("<script type='text/javascript'>" + "alert('중복된 아이디 입니다.');" + "self.close();" + "</script>");
				}

			} catch (Exception e) {
				
				String idchk = request.getParameter("idchk");
				session.setAttribute("idchk", idchk);
				PrintWriter out = response.getWriter();
				out.print("<script type='text/javascript'>" + "alert('사용가능한 아이디입니다.');" + "opener.location.reload();" +"self.close();" +"</script>");
				
			}

		} 
		
		else if (command.equals("idfind")) {

			try {

				String idnamefind = request.getParameter("idnamefind");
				String idphonefind = request.getParameter("idphonefind");
				int idbirthdayfind = Integer.parseInt(request.getParameter("idbirthdayfind"));

				LoginDto dto = dao.idfind(idnamefind, idbirthdayfind, idphonefind);

				if (dto.getMyname().equals(idnamefind) && dto.getMybirthday() == idbirthdayfind	&& dto.getMyphone().equals(idphonefind)) {
					jsResponse(response, "controller.do?command=log", dto.getMyname() + "님의 아이디는 : " + dto.getMyid() + "/" + "비밀번호는 : " + dto.getMypw() + " 입니다.");

					String usermail = dto.getMyemail();
					String userid = dto.getMyid();
					String userpw = dto.getMypw();

					System.out.println(usermail);
					System.out.println(userid);
					System.out.println(userpw);

					request.setAttribute("idfindmail", usermail);
					request.setAttribute("idfindid", userid);
					request.setAttribute("idfindpw", userpw);

					RequestDispatcher mail = request.getRequestDispatcher("findinformail.jsp");
					mail.forward(request, response);
				}

			} catch (Exception e) {
				alertResponse(response, "회원님의 정보가 일치하지 않습니다.");
			}

		} 
		
		else if (command.equals("kakaologin")) {

			try {

				String kakaoid = request.getParameter("kakaoid");
				String kakaopw = request.getParameter("kakaoemail");
				System.out.println(kakaoid);
				System.out.println(kakaopw);
				LoginDto dto = new LoginDto(kakaoid, kakaopw, null, null, 0, null, null, null);
				int res = dao.kakaoinsert(dto);
				System.out.println("회원가입 성공");
				LoginDto kakao = dao.login(kakaoid, kakaopw);
				System.out.println("로그인 성공1");
				//HttpSession session = request.getSession();
				session.setAttribute("dto", kakao);
				session.setMaxInactiveInterval(60 * 60);

			} catch (Exception e) {

				String kakaoid = request.getParameter("kakaoid");
				String kakaopw = request.getParameter("kakaoemail");
				System.out.println(kakaoid);
				System.out.println(kakaopw);
				LoginDto kakao = dao.login(kakaoid, kakaopw);
				System.out.println("로그인 성공2");
				//HttpSession session = request.getSession();
				session.setAttribute("dto", kakao);
				session.setMaxInactiveInterval(60 * 60);
			}

		} 
		
		else if (command.equals("logout")) {
			//HttpSession session = request.getSession();
			session.invalidate();
			// jsResponse(response, "controller.do?command=log", "로그아웃");
			RequestDispatcher logout = request.getRequestDispatcher("login.jsp");
			logout.forward(request, response);

		} 
		
		else if (command.equals("userupdate")) {

			try {
				String pass = request.getParameter("updatepassword");
				String addr = request.getParameter("updateaddr");
				String phone = request.getParameter("updatephone");
				String mail = request.getParameter("updatemail");
				String id = request.getParameter("updateid");

				LoginDto dto = new LoginDto(pass, addr, phone, mail, id);

				int res = dao.userupdate(dto);

				if (res > 0) {
					session.invalidate();
					jsResponse(response, "login.jsp", "정보가 수정되었습니다! 다시 로그인 해주세요");
					
				} 
				else {
					jsResponse(response, "controller.do?command=updateuser", "정보 수정 실패");
				}
			} catch (Exception e) {
				String pass = request.getParameter("updatepassword");
				String addr = request.getParameter("updateaddr");
				String phone = request.getParameter("updatephone");
				String mail = request.getParameter("updatemail");
				String id = request.getParameter("updateid");

				LoginDto dto = new LoginDto(pass, addr, phone, mail, id);
				
				if(dto.getMyemail().equals(mail)) {
					jsResponse(response, "controller.do?command=updateuser", "중복된 이메일입니다.");
				}else if(dto.getMyphone().equals(phone)) {
					jsResponse(response, "controller.do?command=updateuser", "중복된 전화번호입니다.");
				}else {
					jsResponse(response, "controller.do?command=updateuser", "중복된 전화번호와 이메일입니다.");
				}
				
			}

		} 
		
		else if (command.equals("userdelete")) {
			String id = request.getParameter("deleteid");
			if(caldao.selectDiaryAll(id) == null) {
				if(caldao.selectInbodyMyid(id) != null) {
					caldao.deleteInbody(id);
				}
			}else {
				caldao.deleteDiaryMyid(id);
				if(caldao.selectInbodyMyid(id) != null) {
					caldao.deleteInbody(id);
				}
			}
			
			System.out.println(id);
			
			int delAns = ansdao.deleteAnsId(id);
			int delChoice = choicedao.deleteChoiceId(id);
			int delboard = boarddao.deleteBoardId(id);
			
			int res = dao.userdelete(id);
			System.out.println(res);
			if (res > 0) {
				jsResponse(response, "controller.do?command=log", "탈퇴 되었습니다.");
			} 
			else {
				jsResponse(response, "controller.do?command=log", "탈퇴 실패");
			}
		}else if(command.equals("refresh")) {
			session.invalidate();
			response.sendRedirect("userinfor.jsp");
			
		}
		
		//------------------------------------------------------------------------로그인 및 회원
		
		//-------------------------------------------------------------------------커뮤
		
				else if(command.equals("selectList")) {
		    		
		    		int page = Integer.parseInt(request.getParameter("page"));
		    		List<boardDto> list = boarddao.BoardList(page);
		    		int cnt = boarddao.getCnt();
		    		
		    		request.setAttribute("list", list);
		    		request.setAttribute("cnt", cnt);
		    		dispatch(request, response, "post.jsp");
		    	}
		    	
		    	else if(command.equals("insertBoard")) {
		    		
		    		boardDto boarddto = new boardDto();
		    		boarddto.setMyid(request.getParameter("myid"));
		    		boarddto.setBoardno(Integer.parseInt(request.getParameter("boardno")));
		    		boarddto.setAddr(request.getParameter("addr"));
		    		boarddto.setTitle(request.getParameter("title"));
		    		boarddto.setContent(request.getParameter("smarteditor"));
		    		
		    		int res = boarddao.insertBoard(boarddto);
		    		
		    		String nextpage = "command=selectList&page=1";
		    		
		    		if(res > 0) {
		    			request.setAttribute("nextpage", nextpage);
		        		dispatch(request, response, "next.jsp");
		    		}
		    	}
		    	
		    	else if(command.equals("boardOne")) {
		    		
		    		int boardseq = Integer.parseInt(request.getParameter("boardseq"));
		    		int pagecnt = Integer.parseInt(request.getParameter("page"));
		    		
		    		int visit = boarddao.updateVisit(boardseq);
		    		
		    		boardDto boarddto = boarddao.BoardOne(boardseq);
		    		int anscnt = ansdao.getAnsCnt(boardseq);
		    		
		    		List<ansDto> anslist = ansdao.ansList(boardseq,pagecnt);
		    		
		    		request.setAttribute("boarddto", boarddto);
		    		request.setAttribute("anslist", anslist);
		    		request.setAttribute("anscnt", anscnt);
		    		dispatch(request, response, "post_detail.jsp");
		    	}
		    	
		    	else if(command.equals("deleteOne")) {
		    		
		    		int boardseq = Integer.parseInt(request.getParameter("boardseq"));
		    		
		    		//공감 지우고 답글 지우고 게시판 지우면 되겠당!!
		    		int res_choice = choicedao.deleteChoice(boardseq);
		    		int res_ans = ansdao.deleteAnsAll(boardseq);
		    		int res_board = boarddao.deleteBoard(boardseq);
		    		
		    		String nextpage = "command=selectList&page=1";
		    		
		    		if(res_board > 0) {
		    			request.setAttribute("nextpage", nextpage);
		        		dispatch(request, response, "next.jsp");
		    		}
		    	}
		    	
		    	else if(command.equals("searchResult")) {
		    		
		    		String searchtext = request.getParameter("searchtext");
		    		int sort = Integer.parseInt(request.getParameter("sort"));
		    		int page = Integer.parseInt(request.getParameter("page"));
		    		
		    		List<boardDto> list = null;
		    		int cnt = 0;
		    		
		    		if(sort == 1) {
		    			//글 제목 검색
		        		
		    			list = boarddao.titleBoardList(page, searchtext);
		        		cnt = boarddao.getTitleCnt(searchtext);
		        		
		        		request.setAttribute("searchtext", searchtext);
		        		request.setAttribute("list", list);
		        		request.setAttribute("cnt", cnt);
		        		request.setAttribute("page", page);
		        		request.setAttribute("sort", sort);
		        		dispatch(request, response, "post_search.jsp");
		    		}
		    		else if(sort == 2) {
		    			//작성자 검색
		    			list = boarddao.writerBoardList(page, searchtext);
		        		cnt = boarddao.getWriterCnt(searchtext);
		        		
		        		request.setAttribute("searchtext", searchtext);
		        		request.setAttribute("list", list);
		        		request.setAttribute("cnt", cnt);
		        		request.setAttribute("page", page);
		        		request.setAttribute("sort", sort);
		        		dispatch(request, response, "post_search.jsp");
		    		}
		    		
		    		else if(sort == 3) {
		    			
		    			list = boarddao.ansBoardList(page, searchtext);
		    			cnt = ansdao.getWriterAnsCnt(searchtext);
		    			
		    			request.setAttribute("searchtext", searchtext);
		        		request.setAttribute("list", list);
		        		request.setAttribute("cnt", cnt);
		        		request.setAttribute("page", page);
		        		request.setAttribute("sort", sort);
		        		dispatch(request, response, "post_search.jsp");
		    		}
		    		else {
		    			System.out.println("아 망했으요!!!!");
		    		}
		    		
		    	}
		    	
		    	
		    	//커뮤니티 초이스
		    	else if(command.equals("choice")) {
		    		
		    		int boardseq = Integer.parseInt(request.getParameter("boardseq"));
		    		String myid = request.getParameter("myid");
		    		String choice = request.getParameter("choice");
		    		
		    		choiceDto choicedto = new choiceDto();
		    		choicedto.setBoardseq(boardseq);
		    		choicedto.setMyid(myid);
		    		choicedto.setChoice(choice);
		    		
		    		int delvi = boarddao.updateVisits(boardseq);
		    		int res = choicedao.choice(choicedto);
		    		
		    		String nextpage = "command=boardOne&page=1&boardseq="+boardseq;
		    		
		    		if(res > 0) {
		    			request.setAttribute("nextpage", nextpage);
		        		dispatch(request, response, "next.jsp");
		    		}
		    		else {
		    			System.out.println("먼가 잘못되었따...");
		    		}
		    	}
		    	
		    	
		    	//커뮤니티 답글
		    	else if(command.equals("insertAns")) {
		    		
		    		int boardseq = Integer.parseInt(request.getParameter("boardseq"));
		    		String myid = request.getParameter("myid");
		    		String anscontent = request.getParameter("anscontent");
		    		
		    		ansDto ansdto = new ansDto();
		    		ansdto.setBoardseq(boardseq);
		    		ansdto.setMyid(myid);
		    		ansdto.setAnscontent(anscontent);
		    		
		    		int delvi = boarddao.updateVisits(boardseq);
		    		int res = ansdao.insertAns(ansdto);
		    		
		    		String nextpage = "command=boardOne&page=1&boardseq="+boardseq;
		    		
		    		if(res > 0) {
		    			request.setAttribute("nextpage", nextpage);
		        		dispatch(request, response, "next.jsp");
		    		}
		    	}
		    	
		    	else if(command.equals("deleteAns")) {
		    		
		    		int boardseq = Integer.parseInt(request.getParameter("boardseq"));
		    		int ansno = Integer.parseInt(request.getParameter("ansno"));
		    		
		    		int delvi = boarddao.updateVisits(boardseq);
		    		int res = ansdao.deleteAns(ansno);
		    		

		    		String nextpage = "command=boardOne&page=1&boardseq="+boardseq;
		    		
		    		if(res > 0) {
		    			request.setAttribute("nextpage", nextpage);
		        		dispatch(request, response, "next.jsp");
		    		}
		    		
		    	}
				
		    	else if(command.equals("selectTema")) {
		    		
		    		int pagecnt = Integer.parseInt(request.getParameter("pagecnt"));
		    		int boardno = Integer.parseInt(request.getParameter("boardno"));
		    		
		    		List<boardDto> list = boarddao.temaBoardList(pagecnt, boardno);
		    		int cnt = boarddao.getTemaCnt(boardno);
		    		
		    		request.setAttribute("list", list);
		    		request.setAttribute("cnt", cnt);
		    		request.setAttribute("page", pagecnt);
		    		request.setAttribute("boardno", boardno);
		    		dispatch(request, response, "post_tema.jsp");
		    		
		    	}
				
		    	else if(command.equals("updateOne")) {
		    		
		    		int boardseq = Integer.parseInt(request.getParameter("boardseq"));
		    		boardDto boarddto = boarddao.BoardOne(boardseq);
		    		
		    		request.setAttribute("boarddto", boarddto);
		    		request.setAttribute("boardseq", boardseq);
		    		dispatch(request, response, "post_update.jsp");
		    	}
				
		    	else if(command.equals("updateBoard")) {
		    		
		    		boardDto boarddto = new boardDto();
		    		boarddto.setBoardseq(Integer.parseInt(request.getParameter("boardseq")));
		    		boarddto.setTitle(request.getParameter("title"));
		    		boarddto.setContent(request.getParameter("smarteditor"));
		    		
		    		System.out.println(boarddto.getBoardseq() + "/" + boarddto.getTitle() + "/" + boarddto.getContent());
		    		
		    		int res = boarddao.updateBoard(boarddto);
		    		
		    		String nextpage = "command=boardOne&boardseq="+request.getParameter("boardseq")+"&page=1";
		    		
		    		if(res > 0) {
		    			request.setAttribute("nextpage", nextpage);
		        		dispatch(request, response, "next.jsp");
		    		}
		    	}

		    	else if(command.equals("searchTemaResult")) {
		    		
		    		String searchtext = request.getParameter("searchtext");
		    		int sort = Integer.parseInt(request.getParameter("sort"));
		    		int page = Integer.parseInt(request.getParameter("page"));
		    		int boardno = Integer.parseInt(request.getParameter("boardno"));
		    		
		    		
		    		if(sort == 1) {
		    			//글 제목 검색
		        		
		        		List<boardDto> list = boarddao.titleTemaBoardList(page, searchtext, boardno);
		        		int cnt = boarddao.getTemaTitleCnt(searchtext, boardno);
		        		
		        		request.setAttribute("list", list);
		        		request.setAttribute("cnt", cnt);
		        		request.setAttribute("page", page);
		        		request.setAttribute("boardno", boardno);
		        		dispatch(request, response, "post_tema.jsp");
		    		}
		    		else if(sort == 2) {
		    			//작성자 검색
		    			List<boardDto> list = boarddao.writerTemaBoardList(page, searchtext, boardno);
		        		int cnt = boarddao.getTemaWriterCnt(searchtext, boardno);
		        		
		        		request.setAttribute("list", list);
		        		request.setAttribute("cnt", cnt);
		        		request.setAttribute("page", page);
		        		request.setAttribute("boardno", boardno);
		        		dispatch(request, response, "post_tema.jsp");
		    		}
		    		else {
		    			System.out.println("아 망했으요!!!!");
		    		}
		    	}
				
		    	else if(command.equals("whatlog")) {
		    		jsResponse(response, "login.jsp", "로그인을 해주세요!!");
		    	}
		
		    	else if(command.equals("reload")) {
		    		
		    		alertOne(response, "history.back(-1)");
		    	}
				//-----------------------------------------------커뮤니티
		
		//-------------------------------------------------칼
    	else if(command.equals("updateInbody")) {
			String myid = request.getParameter("myid");
			double weight = Double.parseDouble(request.getParameter("weight"));
			double height = Double.parseDouble(request.getParameter("height"));
			double bmi = Double.parseDouble(request.getParameter("bmi"));
			double meta = Double.parseDouble(request.getParameter("metabolism"));
			
			InbodyDto dto = new InbodyDto(myid, weight, height, bmi, meta);
			caldao.updateInbody(dto);
		}
    	
    	else if(command.equals("openkcal")) {
    		
    		try {
    			InbodyDto inbodydto = null;
    			
    			if(testid == null) {
    				response.sendRedirect("controller.do?command=whatlog");
    			}
    			else {
    				inbodydto = caldao.selectInbodyMyid(testid);
    				
    				if(inbodydto == null){
        				InbodyDto dto = new InbodyDto(testid, 0, 0, 0, 0);
        				caldao.insertInbody(dto);
        				response.sendRedirect("kcal.jsp");
        			}
        			else {
        				response.sendRedirect("kcal.jsp");
        			}
    			}
			} catch (Exception e) {
				response.sendRedirect("kcal.jsp");
			}
		
		}
    	
    	else if(command.equals("callfindExer")) {
	         String finditem = request.getParameter("finditem");
	         List<CalorieDto> list = null;
	         if(caldao.selectExCalorie(finditem).size() == 0) {
	            jsResponse(response, "findexer.jsp", "목록에 해당 검색어가 없습니다. 다시 검색해주세요.");
	         }
	         else {
	            list = caldao.selectExCalorie(finditem);
	            request.setAttribute("list", list);
	            dispatch(request, response, "findexer_select.jsp");
	         }
	         
	      }
    	
    	else if(command.equals("callfindfood")) {
	         String finditem = request.getParameter("finditem");
	         List<CalorieDto> list = null;
	         if(caldao.selectFoodCalorie(finditem).size()==0) {
	            jsResponse(response, "findfood.jsp", "목록에 해당 검색어가 없습니다. 다시 검색해주세요.");
	         }
	         else {
	            list = caldao.selectFoodCalorie(finditem);
	            request.setAttribute("list", list);
	            dispatch(request, response, "findfood_select.jsp");
	         }
		}
    	
    	else if(command.equals("opendaily")) {
			String myid = request.getParameter("myid");
			InbodyDto indto = caldao.selectInbodyMyid(myid);
			request.setAttribute("indto", indto);
			dispatch(request, response, "dailycal.jsp");
		}
    	
    	else if(command.equals("commitDailyInfo")) {
			
			String year = Integer.toString(cal.get(Calendar.YEAR));
			String month = Util.isTwo(Integer.toString(cal.get(Calendar.MONTH)+1));
			String day = Util.isTwo(Integer.toString(cal.get(Calendar.DATE)));
			String mdate = year + month + day;
			
			String myid = request.getParameter("myid");
			double totalcal = Double.parseDouble(request.getParameter("totalcal"));
			double totalconsumed = Double.parseDouble(request.getParameter("totalconsumed"));
			
			DiaryDto diarydto = new DiaryDto(mdate, myid, 0, 0, null);
			DiaryDto selectDto = caldao.selectDiaryOne(diarydto);
			
			if(selectDto == null) {
				DiaryDto insertdto = new DiaryDto(mdate,myid,totalcal,totalconsumed, null);
				caldao.insertDiary(insertdto);
				InbodyDto inbodydto = caldao.selectInbodyMyid(myid);
				request.setAttribute("indto", inbodydto);
				dispatch(request, response, "dailycal.jsp");
			}
			else {
				DiaryDto updatedto = new DiaryDto(mdate,myid,totalcal,totalconsumed, null);
				caldao.updateDiary(updatedto);
				InbodyDto inbodydto = caldao.selectInbodyMyid(myid);
				request.setAttribute("indto", inbodydto);
				dispatch(request, response, "dailycal.jsp");
			}
			
		}
    	
    	else if(command.equals("commitDiaryInfo")) {
			String mDate = request.getParameter("mDate");
			String myid = request.getParameter("myid");
			double totalcal = Double.parseDouble(request.getParameter("totalcal"));
			double totalconsumed = Double.parseDouble(request.getParameter("totalconsumed"));
			
			DiaryDto diarydto = new DiaryDto(mDate, myid, 0, 0, null);
			DiaryDto selectDto = caldao.selectDiaryOne(diarydto);
			
			if(selectDto == null) {
				DiaryDto insertdto = new DiaryDto(mDate,myid,totalcal,totalconsumed, null);
				caldao.insertDiary(insertdto);
				response.sendRedirect("controller.do?command=opendiary&myid="+myid);
			}
			else {
				DiaryDto updatedto = new DiaryDto(mDate,myid,totalcal,totalconsumed, null);
				caldao.updateDiary(updatedto);
				response.sendRedirect("controller.do?command=opendiary&myid="+myid);
			}
			
			
		}
		
		else if(command.equals("opendiary")) {
			String myid = request.getParameter("myid");
			InbodyDto indto = caldao.selectInbodyMyid(myid);
			
			String year = Integer.toString(cal.get(Calendar.YEAR));
			String month = Util.isTwo(Integer.toString(cal.get(Calendar.MONTH)+1));
			String day = Util.isTwo(Integer.toString(cal.get(Calendar.DATE)));
			String mdate = year + month + day;
			
			if(indto.getMetabolism() != 0) {
				List<DiaryDto> myidlist = null; //여기서 문제 사이즈가 0이다
				
				if(caldao.selectDiaryAll(myid).size() == 0) {
					DiaryDto diarydto = new DiaryDto(mdate, myid, 0, 0, null);
					caldao.insertDiary(diarydto);
				}
				else {
					myidlist = caldao.selectDiaryAll(myid);
				}
				
				List<DiaryDto> list = caldao.selectDiaryAll(myid);
				request.setAttribute("diarylist", list);
				dispatch(request, response, "caloriediary.jsp");
				
			}
			else {
				request.setAttribute("msg", "회원님의 다이어리 산출을 위한 신체 데이터가 없습니다. 키와 몸무게를 입력해주세요.");
				request.setAttribute("indto", indto);
				request.setAttribute("pagename", "Diary");
				dispatch(request, response, "inputweight.jsp");
			}
		}
		
		else if(command.equals("inputInfo")) {
			String myid = request.getParameter("myid");
			String gender = request.getParameter("gender");
			String birth = request.getParameter("birth");
			double weight = Double.parseDouble(request.getParameter("weight"));
			double height = Double.parseDouble(request.getParameter("height"));
			String pagename = request.getParameter("pagename");
			int year = cal.get(Calendar.YEAR);
			int subyear = Integer.parseInt(birth.substring(0, 2));
			int iage = 0;
			if(subyear > 19) {
				iage = subyear+1900;
			}
			else {
				iage = subyear+2000;
			}
			
			int age = year - iage + 1;
			double metacal = 0;
			
			if(gender == "W"){
		    	  metacal = 655.1+(9.56*weight)+(1.85*height)-(4.68*age);
		    }
			else{
		    	  metacal = 66.47+(13.75*weight)+(5*height)-(6.76*age);
		    }
			
			double bmi = Util.decimal(weight/((height/100)*(height/100)));
			double meta = Util.decimal(metacal);
			InbodyDto indto = new InbodyDto(myid, weight, height, bmi, meta);
			caldao.updateInbody(indto);
			
			if(pagename.equals("Diary")) {
				response.sendRedirect("controller.do?command=opendiary&myid="+myid);
			}
			else {
				response.sendRedirect("controller.do?command=opendaily&myid="+myid);
			}
			
		}
		
		else if(command.equals("moveyyyyMM")) {
			String myid = request.getParameter("myid");
			String year = request.getParameter("year");
			String month = request.getParameter("month");
			List<DiaryDto> list = new ArrayList<DiaryDto>();
			list = caldao.selectDiaryAll(myid);
			request.setAttribute("year", year);
			request.setAttribute("month", month);
			request.setAttribute("diarylist", list);
			dispatch(request, response, "caloriediary.jsp");
		}
		
		else if(command.equals("dailyNoInfo")) {
			String myid = request.getParameter("myid");
			InbodyDto indto = caldao.selectInbodyMyid(myid);
			request.setAttribute("indto", indto);
			request.setAttribute("pagename", "Daily");
			dispatch(request, response, "inputweight.jsp");
		}
		
		else if(command.equals("deleteDiary")) {
			String myid = request.getParameter("myid");
			String mDate = request.getParameter("mDate");
			DiaryDto dto = new DiaryDto(mDate, myid, 0, 0, null);
			int res = caldao.deleteDiary(dto);
			if(res > 0 ) {
				jsResponse(response, "controller.do?command=opendiary&myid="+myid, "해당 날짜의 데이터를 성공적으로 삭제하였습니다.");
			}
			else {
				jsResponse(response, "controller.do?command=opendiary&myid="+myid, "데이터 삭제에 실패했습니다. 재시도 후 관리자에게 문의바랍니다.");
			}
		}
		
		else if(command.equals("callinsert")) {
			String myid = request.getParameter("myid");
			String mDate = request.getParameter("mDate");
			
			InbodyDto indto = caldao.selectInbodyMyid(myid);
			request.setAttribute("mDate", mDate);
			request.setAttribute("indto", indto);
			dispatch(request, response, "insertDiary.jsp");
		}
		

		else if(command.equals("updateGenBirth")) {
			String myid = request.getParameter("myid");
			String gender = request.getParameter("gender");
			int birth = Integer.parseInt(request.getParameter("birthday"));
			
			LoginDto ldto = new LoginDto(myid, null, null, gender, birth, null, null, null, null, null);
			int res = dao.updateGenBirth(ldto);
			if(res > 0) {
				PrintWriter out = response.getWriter();
				out.print("<script type='text/javascript'>" + "opener.location.reload();" +"self.close();" +"</script>");
			}else {
				PrintWriter out = response.getWriter();
				out.print("<script type='text/javascript'>" + "opener.location.href='login.jsp';" +"self.close();" +"</script>");
			}
		}
		
		
		//------------------------------------------------------------------------------칼
		
		//-------------------------------------------------------------------------------샵
		
		else if(command.equals("main")){
			List<ProductDto> list = pdao.selectAll();
			
			request.setAttribute("list", list);
			dispatch(request, response, "productMain.jsp");
			
		}
		
		else if(command.equals("detail")) {
			int pid = Integer.parseInt(request.getParameter("pid"));
			
			ProductDto prodto = pdao.selectOne(pid);

			request.setAttribute("prodto", prodto);
			String strPageNo = request.getParameter("nowPageNo");
			int pageNo;
			if (strPageNo == null) {
				pageNo = 1;
			} 
			else {
				pageNo = Integer.parseInt(strPageNo);
				request.setAttribute("move", "$(document).ready(function(){$('html, body').animate({scrollTop : $('#detail_tab3').offset().top}, 0);});");
			}
			
			int pageNum = rdao.pageNum(pid);
			ArrayList<ReviewDto> reviewSelect = (ArrayList<ReviewDto>)rdao.reviewSelect(pageNo, pid);

			request.setAttribute("pageNum", pageNum);
			request.setAttribute("reviewSelect", reviewSelect);
			for(ReviewDto review : reviewSelect) {
				System.out.println(review.getR_star());
			}
			System.out.println(pid+":"+strPageNo);

			dispatch(request, response, "productDetail.jsp");
			
		}
		
		else if(command.equals("basket")) {//장바구니 db를 넣음	
			PrintWriter out = response.getWriter();	
			String my_id = request.getParameter("my_id");			
			
			String pname = request.getParameter("pname");
			int pid = Integer.parseInt(request.getParameter("pid"));
			int price = Integer.parseInt(request.getParameter("price"));
			int amount = Integer.parseInt(request.getParameter("amount"));
					
			BasketDto basdto = new BasketDto();
			basdto.setMyid(my_id);
			basdto.setPname(pname);
			basdto.setPid(pid);
			basdto.setPrice(price);
			basdto.setAmount(amount);
			
			int res = bdao.insertBas(basdto);
			System.out.println(res+"=res");
				
			JSONObject obj = new JSONObject();
			obj.put("my_id",my_id);
			obj.put("pname", pname);
			obj.put("pid",pid);
			obj.put("price", price);
			obj.put("amount", amount);
			
			out.println(obj.toJSONString());

		}
		
		else if(command.equals("basket_res")) {//장바구니 페이지로 이동
			LoginDto dto_login = (LoginDto)session.getAttribute("dto");
			String my_id= dto_login.getMyid();
			if(my_id==null || my_id.equals("")){ // id가 Null 이거나 없을 경우
				jsResponse(response, "login.jsp", "basket_res:로그인을 해야 장바구니보기가 가능합니다.");// 로그인 페이지로 리다이렉트 한다.
			}
			List<BasketDto> list = bdao.BasketAll(my_id);
			
			System.out.println("list="+list);
			request.setAttribute("list", list);
			dispatch(request, response, "productBasket.jsp");
			
		}
		
		else if(command.equals("multidel")) {
			String[] chks = request.getParameterValues("chk");
			System.out.println("체크된 basket_seq : " + Arrays.toString(chks));
			
			if(chks == null) {
				jsResponse(response, "controller.do?command=basket_res", "삭제할 상품을 하나 이상 체크해주세요.");
			}
			else {
				int res = bdao.muldelBas(chks);		
				jsResponse(response, "controller.do?command=basket_res", res+"개 삭제성공");
			}
				
		}
		
		else if(command.equals("multiPay")){
			String[] chks = request.getParameterValues("chk");
			System.out.println("체크된 basket_seq : " + Arrays.toString(chks));
			
			if(chks == null) {
				jsResponse(response, "controller.do?command=basket_res", "결제할 상품을 하나 이상 체크해주세요.");
			}
			else {
				int sum = bdao.sumBas(chks);
				List<BasketDto> list = bdao.BasketSelect(chks);
				System.out.println(list);
				System.out.println(sum);
				request.setAttribute("list", list);
				request.setAttribute("sum", sum);
				int num = 1;
				for(int i=0; i < chks.length; i++) {
					num += i;
				}
				alertOne(response, "결제할 상품은"+num+"개 입니다.");
				dispatch(request, response, "productPay.jsp");
//				jsResponse(response, "productPay.jsp", "결제할 상품은 " + num + "개 입니다.");
			}
				
		}
		
		else if(command.equals("payment")) {
				
			LoginDto Ldto= (LoginDto)session.getAttribute("dto");
			String my_id= Ldto.getMyid();
			
			BasketDto Bdto = new BasketDto();
			Bdto.setMyid(my_id);
			
			int sum = bdao.sumBas0(Bdto);
			List<BasketDto> list = bdao.BasketAll(my_id);
			System.out.println("list");
			
			System.out.println(sum);
			System.out.println(list);
			request.setAttribute("list", list);
			request.setAttribute("sum", sum);
			dispatch(request, response, "productPay.jsp");
			
		}
		
		else if(command.equals("sale")) {
			System.out.println("확인11");
			//BasketDto dto = new BasketDto();
				
			String my_id = request.getParameter("my_id");
			System.out.println(my_id+"=my_id");
			String addr = request.getParameter("addr");
			String basseq = request.getParameter("basseq");
			String[] basket_seq = basseq.split(",");
			System.out.println(my_id+"/"+addr+"/"+basseq);
				
				
			List<BasketDto> list = bdao.BasketSelect(basket_seq);
			SaleorderDto sdto = new SaleorderDto();
			int res = 0;
			int del = bdao.muldelBas(basket_seq);
			System.out.println(del);
			for(BasketDto bdto  : list) {
				sdto.setMyid(my_id);
				sdto.setAddr(addr);
				sdto.setPid(bdto.getPid());
				sdto.setPname(bdto.getPname());
				sdto.setAmount(bdto.getAmount());
				sdto.setPrice(bdto.getPrice());
				sdto.setOrder_date(null);
				sdto.setOrder_state(0);
				
				res = sdao.insertOrder(sdto);
				System.out.println(res);
			}
				
			if(res>0 || del>0) {
				
				List<SaleorderDto> slist = sdao.selectOrder(my_id);
				System.out.println("slist"+slist);
				request.setAttribute("slist", slist);
				dispatch(request, response, "productOrder.jsp");
			}

		}
		
		else if(command.equals("payone")) {
	         LoginDto dto_login = (LoginDto) session.getAttribute("dto");
	         String my_id= dto_login.getMyid();

	         
	         int pid = Integer.parseInt(request.getParameter("pid"));
	         int price= Integer.parseInt(request.getParameter("price"));
	         int amount = Integer.parseInt(request.getParameter("amount"));
	         System.out.println(pid+price+amount);
	         ProductDto prodto = pdao.selectOne(pid);
	         
	         request.setAttribute("my_id", my_id);
	         request.setAttribute("prodto", prodto);
	         request.setAttribute("price", price);
	         request.setAttribute("amount", amount);
	         dispatch(request, response, "productPayOne.jsp");
	            
	      }
		
		else if(command.equals("saleOne")) {
			System.out.println("확인22");
			String Onemy_id = request.getParameter("my_id");
			System.out.println("my_id"+Onemy_id);
			String Oneaddr = request.getParameter("addr");
			int Onepid = Integer.parseInt(request.getParameter("pid"));
				
			ProductDto pdto = pdao.selectOne(Onepid);
			SaleorderDto sdto = new SaleorderDto(0,Onepid,pdto.getPname(),Onemy_id,Oneaddr,1,1,null,0);
				
			int res = sdao.insertOrder(sdto);
				
				
			if(res>0) {
				List<SaleorderDto> slist = sdao.selectOrder(Onemy_id);
				System.out.println("slist"+slist);
				request.setAttribute("slist", slist);
				dispatch(request, response, "productOrder.jsp");
			}
			
		}
		
		else if(command.equals("writeReview")) {
			int pid = Integer.parseInt(request.getParameter("pid"));
			System.out.println(pid+"=pid");
			int r_star = Integer.parseInt(request.getParameter("star"));
			String my_id = request.getParameter("my_id");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			String img = "img";
					
			ReviewDto rdto = new ReviewDto(0,pid,r_star,my_id,title,content,img,null);
			int res = rdao.insertReview(rdto);
				
			if(res>0) {
				jsResponse(response, "controller.do?command=payLook&my_id="+my_id, "Review작성완료");
			}
					
		}
		
		else if(command.equals("detailReview")) {
			int r_no = Integer.parseInt(request.getParameter("r_no"));
			System.out.println("r_no="+r_no);
					
			ReviewDto rdto = rdao.detailReview(r_no);
			request.setAttribute("rdto", rdto);
			dispatch(request, response, "productReview.jsp");
		}
		
		else if(command.equals("payLook")){
            
            String my_id = (String)request.getParameter("my_id");
            System.out.println(my_id);
            List<SaleorderDto> slist = sdao.selectOrder(my_id);
            System.out.println("slist"+slist);
            request.setAttribute("slist", slist);
            dispatch(request, response, "productOrder.jsp");
            
         }
		
		else if(command.equals("selectINFOBOARD")) {
			int bno = Integer.parseInt(request.getParameter("boardno"));
			int page = Integer.parseInt(request.getParameter("page"));
			
			
			if(bno == 1) {
				
				List<BikeDto> list = infodao.selectBikeBOARD(page);
				request.setAttribute("list", list);
				dispatch(request, response, "about_bike.jsp");
			}else if(bno == 2) {
				
				List<InfoBoardDto> list = infodao.selectINFOBOARD(page,bno);
				
				request.setAttribute("list", list);
				dispatch(request, response, "about_health.jsp");
			}else {
				
				List<InfoBoardDto> list = infodao.selectINFOBOARD(page,bno);
				
				request.setAttribute("list", list);
				dispatch(request, response, "about_path.jsp");
			}
		}
		
		else if(command.equals("selectAbout")) {
			int myno = Integer.parseInt(request.getParameter("myno"));
			
			InfoBoardDto infodto = infodao.selectOne(myno);
			
			request.setAttribute("infodto", infodto);
			dispatch(request, response, "about_select.jsp");
		}
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		getMsg(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		getMsg(request, response);
	}

	public void dispatch(HttpServletRequest request, HttpServletResponse response, String url)
			throws ServletException, IOException {
		RequestDispatcher dispatch = request.getRequestDispatcher(url);
		dispatch.forward(request, response);
	}

	// 경고창 띄우기
	public void jsResponse(HttpServletResponse response, String url, String msg) throws IOException {
		String tmp = "<script type='text/javascript'>" + "alert('" + msg + "');" + "location.href='" + url + "';"
				+ "</script>";
		PrintWriter out = response.getWriter();
		out.print(tmp);
	}

	// 알람 띠우고 다시 원래 페이지로
	public void alertResponse(HttpServletResponse response, String msg) throws IOException {
		String tmp = "<script type='text/javascript'>" + "alert('" + msg + "');" + "history.go(-1);" + "</script>";
		PrintWriter out = response.getWriter();
		out.print(tmp);
	}

	// 자바스크립트 사용
	public void alertOne(HttpServletResponse response, String msg) throws IOException {
		String tmp = "<script type='text/javascript'>" + msg + "</script>";
		PrintWriter out = response.getWriter();
		out.print(tmp);

	}

}
