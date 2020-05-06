var form, $, areaData;
layui.config({
    base: "../../js/"
})
layui.use(['form', 'layer', 'upload', 'laydate', "address"], function () {
    form = layui.form;
    $ = layui.jquery;
    var layer = parent.layer === undefined ? layui.layer : top.layer

    //提交个人资料
    form.on("submit(submit)", function (data) {
        var index = layer.msg('提交中，请稍候', {icon: 16, time: false, shade: 0.8});
        //注意：parent 是 JS 自带的全局对象，可用于操作父页面
        var curIndex = parent.layer.getFrameIndex(window.name); //获取窗口索引
        $.post("/common/employee/changePwd", {
            oldPassword: $("#oldPwd").val(),
            newPassword: $("#newPwd").val(),
            newPassword1: $("#newPwd1").val(),
        }, function (res) {
            setTimeout(function () {
                layer.msg(res.msg);
                if (res.code == 213){
                    setTimeout(function () {
                        parent.layer.close(curIndex)
                    },500)
                    layer.close(index);
                }
            }, 1000);

        })
        return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
    })
})