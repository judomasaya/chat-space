$(function(){ 

  function buildHTML(message){
    let image = ( message.image ) ? `<img class= "lower-message__image" src=${message.image} >` : "";

  //messageクラスにdata-message-idを付与
    let html = `<div class="message", "data-message-id"="${message.id}">


                  <div class="upper-message">
                    <div class="upper-message__user-name">
                    ${message.user_name}
                    </div>
                    <div class="upper-message__date">
                    ${message.date}
                    </div>
                  </div>
                  <div class="lower-message">
                    <p class="lower-message__content">
                    ${message.content}
                    </p>
                    ${image}
                  </div>
                </div> `
        return html;
  }

  $('#new_message').on('submit', function(e){
  e.preventDefault();
  var formData = new FormData(this);
  var url = $(this).attr('action')
  
  $.ajax({
    url: url,
    type: "POST",
    data: formData,
    dataType: 'json',
    processData: false,
    contentType: false
  })
  .done(function(data){
    var html = buildHTML(data);
    $('.messages').append(html);      
    $('form')[0].reset();
    $('.messages').animate({ scrollTop: $('.messages')[0].scrollHeight});
  })
  .fail(function() {
    alert("メッセージ送信に失敗しました");
  });
  return false;
  })

  //自動更新用の関数定義
  var reloadMessages = function () {
  
  //ブラウザに表示されている最後のメッセージからidを取得して、変数に代入
  var last_message_id = $('.message:last').data("message-id");
  
  //ajaxの処理   
  $.ajax({
    
    //今回はapiのmessagesコントローラーに飛ばす
    url: "api/messages",
    //HTTP＿メソッド
    type: 'get',
    //データはjson型で
    dataType: 'json',
    
    //キーを自分で決め（今回はｌａｓｔ_id)そこに先ほど定義したlast_message_idを代入。これはコントローラーのparamsで取得される。
    data: {last_id: last_message_id} 
  })
  
  .done(function(messages) {
    if (messages.length !== 0) {
      //追加するHTMLの入れ物を作る
      var insertHTML = '';
      //配列messagesの中身一つ一つを取り出し、HTMLに変換したものを入れ物に足し合わせる
      $.each(messages, function(i, message) {
        insertHTML += buildHTML(message)
      });
      //メッセージが入ったHTMLに、入れ物ごと追加
      $('.messages').append(insertHTML);
      // メッセージ分だけスクロールするよう実装
      $('.messages').animate({ scrollTop: $('.messages')[0].scrollHeight});
    }
  })

  .fail(function() {
    alert('error');
  });
};

  if (document.location.href.match(/\/groups\/\d+\/messages/)) {
    setInterval(reloadMessages, 5000);
    //これにより５０００ミリ秒ごとにreloadMessagesが呼び出される※処理の外に記述
  }
});