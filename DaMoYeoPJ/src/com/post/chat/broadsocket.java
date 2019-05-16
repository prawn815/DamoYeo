package com.post.chat;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/broadsocket")
public class broadsocket {
	//유저 집합 리스트
    static List<Session> sessionUsers = Collections.synchronizedList(new ArrayList<>());
     
    /**
     * 웹 소켓이 접속되면 유저리스트에 세션을 넣는다.
     * @param userSession 웹 소켓 세션
     */
    @OnOpen
    public void handleOpen(Session userSession){
        sessionUsers.add(userSession);
        System.out.println(userSession);
    }
    /**
     * 웹 소켓으로부터 메시지가 오면 호출한다.
     * @param message 메시지
     * @param userSession
     * @throws IOException
     */
    @OnMessage
    public void handleMessage(String message,Session userSession) throws IOException{
        String username = (String)userSession.getUserProperties().get("username");
        //그 머시기 세션이 들어오묜 그 양식에 맞춰서 수정
        
        //최초 메시지는 username설정
        if(username == null){
            userSession.getUserProperties().put("username", message);
            return;
        }
        //username이 있으면 전체에게 메시지를 보낸다.
        Iterator<Session> iterator = sessionUsers.iterator();
        while(iterator.hasNext()){
            iterator.next().getBasicRemote().sendText(username + " : " + message);
        }
    }
    /**
     * 웹소켓을 닫으면 해당 유저를 유저리스트에서 뺀다.
     * @param userSession
     */
    @OnClose
    public void handleClose(Session userSession){
        sessionUsers.remove(userSession);
    }
    
    //여기는 아직 미완성이라 아직 안함 ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ
    /**
     * json타입의 메시지 만들기
     * @param username
     * @param message
     * @return
     */
    /*public String buildJsonData(String username,String message){
        JSONObject jsonObject = JSON.createObjectBuilder().add("message", username+" : "+message).build();
        StringWriter stringwriter =  new StringWriter();
        try(jsonWriter jsonWriter = Json.createWriter(stringwriter)){
                jsonWriter.write(jsonObject);
        };
        return stringwriter.toString();
    }*/
}