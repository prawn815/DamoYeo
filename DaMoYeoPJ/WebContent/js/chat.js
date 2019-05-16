
		//웹소켓 초기화
        var webSocket = new WebSocket("ws://192.168.10.22:8787/DaMoYeoPJ/broadsocket");
        var messageTextArea = document.getElementById("messageTextArea");
        //메시지가 오면 messageTextArea요소에 메시지를 추가한다.
        webSocket.onmessage = function processMessge(message){
            var msg = message.data;
            if(msg != null) {
                messageTextArea.value += msg + "\n"
                var elem = document.getElementById('messageTextArea');
                elem.scrollTop = elem.scrollHeight;
            };
        }
        //메시지 보내기
        function sendMessage(){
            setTimeout(function() {
            	var messageText = document.getElementById("messageText");
            	webSocket.send(messageText.value);
            	 messageText.value = "";
            }, 50);
        }
        
        function enterkey() {
            if (window.event.keyCode == 13) {
            	sendMessage();
            }
        }
        