layui.use(['form','layer','jquery'],function(){
    var form = layui.form,
        layer = parent.layer === undefined ? layui.layer : top.layer
        $ = layui.jquery;


    $(document).ready(function(){
        var msg = $("#msg").val()
        if (msg == 'fail') {
            layer.alert("用户名或者密码错误");
        }
    });

    //登录按钮
    form.on("submit(login)",function(data){
        var username = $("#username").val();
        var password = $("#password").val();
        var role = data.field.role;
        $(this).text("登录中...").attr("disabled","disabled").addClass("layui-disabled");
        setTimeout(function(){
            $.post("/doLogin", {
                username: username,  //id
                password: password,
                role:role
            }, function (data) {
                window.location.href = "/toIndex"+"?page="+data;
            })
            // window.location.href = "/doLogin"+"?username="+username +"&password="+password+"&role="+role;
            // window.location.replace("/doLogin\"+\"?username=\"+username +\"&password=\"+password");
        },1000);
        return false;
    })

    //表单输入效果
    $(".loginBody .input-item").click(function(e){
        e.stopPropagation();
        $(this).addClass("layui-input-focus").find(".layui-input").focus();
    })
    $(".loginBody .layui-form-item .layui-input").focus(function(){
        $(this).parent().addClass("layui-input-focus");
    })
    $(".loginBody .layui-form-item .layui-input").blur(function(){
        $(this).parent().removeClass("layui-input-focus");
        if($(this).val() != ''){
            $(this).parent().addClass("layui-input-active");
        }else{
            $(this).parent().removeClass("layui-input-active");
        }
    })
})
