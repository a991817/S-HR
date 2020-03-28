layui.use(['form','layer'],function(){
    var form = layui.form
        layer = parent.layer === undefined ? layui.layer : top.layer,
        $ = layui.jquery;
    //提交数据
    form.on("submit(addEmployee)",function(data){
        //弹出loading
        var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
        // 实际使用时的提交信息
        $.post("employeeAdd",{
            id : $("#employeeId").val(),
            name : $("#name").val(),  //姓名
            idNumber : $("#idNumber").val(),  //身份证
            birthday : $("#birthday").val(),  //生日
            phone : $("#phone").val(),  //手机
            email : $("#email").val(),    //邮箱
            nativePlace : $("#nativePlace").val(),    //籍贯
            gender : $("#gender option:selected").text(),//性别
            workState: $("#wordState option:selected").val(),//在职状态
            wedlock: $("#wedlock option:selected").val(),//婚姻状态
            departmentId : $("#department option:selected").val(),//部门
            positionId :$("#position option:selected").val(),//职位
            submitType : $("#submitType").val()//提交类型
        },function(res){
            if (res.code == 201 || res.code == 203){
                setTimeout(function() {
                    top.layer.close(index);
                    if (res.code == 201) {
                        top.layer.msg("用户添加成功！");
                    }else{
                        top.layer.msg("用户修改成功！");
                    }
                    layer.closeAll("iframe");
                    //刷新父页面
                    parent.location.reload();
                },2000);
            }else{
                setTimeout(function(){
                    top.layer.close(index);
                    top.layer.msg(res.msg);
                    layer.closeAll("iframe");
                },2000);
            }
        })
        return false;
    })


    //格式化时间
    function filterTime(val){
        if(val < 10){
            return "0" + val;
        }else{
            return val;
        }
    }
    //定时发布
    var time = new Date();
    var submitTime = time.getFullYear()+'-'+filterTime(time.getMonth()+1)+'-'+filterTime(time.getDate())+' '+filterTime(time.getHours())+':'+filterTime(time.getMinutes())+':'+filterTime(time.getSeconds());

})