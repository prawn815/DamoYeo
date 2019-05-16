package com.semi.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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

import com.cal.dao.CalorieDao;
import com.cal.dao.Util;
import com.cal.dto.CalorieDto;
import com.cal.dto.DiaryDto;
import com.cal.dto.InbodyDto;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


@WebServlet("/ajaxcontroller.do")
public class CalAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CalAjax() {
        super();
    }
    
    protected void getMsg(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		HttpSession session = request.getSession();
		
		String command = request.getParameter("command");
		System.out.println("[" + command + "]");
		
		CalorieDao dao = new CalorieDao();
		
		if(command.equals("detailView")) {
			String id = request.getParameter("id");
			String mDate = request.getParameter("mDate");
			
			System.out.println(id + "/" + mDate);
			
			DiaryDto dto = new DiaryDto(mDate, id, 0, 0, null);
			DiaryDto mDateDto = dao.selectDiaryOne(dto);
			
			Map<String, Double> map = new HashMap<String, Double>();
			map.put("mtotalcal", mDateDto.getTotalcal());
			map.put("mtotalmeta", mDateDto.getTotalmeta());
			
			// 라이브러리에 넣어둔 jar 파일들에 만들어져 있는 코드들..
			JSONObject obj = JSONObject.fromObject(map);
			PrintWriter out = response.getWriter();
			obj.write(out);
		}else if(command.equals("updateInbody")) {
			String kcalInfo = request.getParameter("kcalInfo");
			String[] kcalArr = kcalInfo.split(",");
			
			String myid = kcalArr[0];
			double weight = Double.parseDouble(kcalArr[1]);
			double height = Double.parseDouble(kcalArr[2]);
			double bmi = Double.parseDouble(kcalArr[3]);
			double meta = Double.parseDouble(kcalArr[4]);
			
			InbodyDto dto = new InbodyDto(myid, weight, height, bmi, meta);
			dao.updateInbody(dto);
		}else if(command.equals("makechart")) {
			String myid = request.getParameter("myid");
			String yyyyMM = request.getParameter("yyyyMM");
			int lastDay = Integer.parseInt(request.getParameter("lastDay"));
			
			List<DiaryDto> diarylist = dao.selectDiaryAll(myid);
			
			JSONObject data = new JSONObject();
			JSONObject ajaxObjCols1 = new JSONObject();   
			JSONObject ajaxObjCols2 = new JSONObject();   
			JSONObject ajaxObjCols3 = new JSONObject();   
			JSONObject ajaxObjCols4 = new JSONObject();
			
			ajaxObjCols1.put("type", "string");
			ajaxObjCols2.put("label", "섭취 칼로리");
			ajaxObjCols2.put("type", "number");
			ajaxObjCols3.put("label", "소비 칼로리");
			ajaxObjCols3.put("type", "number");
			ajaxObjCols4.put("label", "잔여 칼로리");
			ajaxObjCols4.put("type", "number");
			
			JSONArray ajaxArryRows = new JSONArray();
			JSONArray ajaxArryCols = new JSONArray();
			ajaxArryCols.add(ajaxObjCols1);
			ajaxArryCols.add(ajaxObjCols2);
			ajaxArryCols.add(ajaxObjCols3);
			ajaxArryCols.add(ajaxObjCols4);			

			for(int i = 0; i < diarylist.size(); i++) {
				if(diarylist.get(i).getMdate().substring(0, 6).equals(yyyyMM)) {
					if(diarylist.get(i).getTotalcal() == 0 && diarylist.get(i).getTotalmeta() == 0) {
						
					}else {
						JSONObject mdate = new JSONObject();
						mdate.put("v",diarylist.get(i).getMdate().substring(6, 8)+"일");
						mdate.put("f", null);
						
						JSONObject eatcal = new JSONObject();
						eatcal.put("v",diarylist.get(i).getTotalcal());
						eatcal.put("f", null);
						
						JSONObject concal = new JSONObject();
						concal.put("v",diarylist.get(i).getTotalmeta());
						concal.put("f", null);
						
						JSONObject subcal = new JSONObject();
						subcal.put("v", Util.decimal((diarylist.get(i).getTotalcal()-diarylist.get(i).getTotalmeta())));
						subcal.put("f", null);
						
						JSONArray cValueArray = new JSONArray();
						cValueArray.add(mdate);
						cValueArray.add(eatcal);
						cValueArray.add(concal);
						cValueArray.add(subcal);
						
						JSONObject cValueObj = new JSONObject();
						cValueObj.put("c", cValueArray);
						
						ajaxArryRows.add(cValueObj);
					}
				}
			}
			
			data.put("cols", ajaxArryCols);
			data.put("rows", ajaxArryRows);
			
			PrintWriter out = response.getWriter();
			data.write(out);
		}
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		getMsg(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
