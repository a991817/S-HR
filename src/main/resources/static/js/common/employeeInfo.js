var form, $,areaData;
layui.config({
    base : "../../js/"
}).extend({
    "address" : "address"
})
layui.use(['form','layer','upload','laydate',"address"],function(){
    form = layui.form;
    $ = layui.jquery;
    var layer = parent.layer === undefined ? layui.layer : top.layer,
        upload = layui.upload,
        laydate = layui.laydate,
        address = layui.address;


    //添加验证规则
    form.verify({
        userBirthday : function(value){
            if(!/^(\d{4})[\u4e00-\u9fa5]|[-\/](\d{1}|0\d{1}|1[0-2])([\u4e00-\u9fa5]|[-\/](\d{1}|0\d{1}|[1-2][0-9]|3[0-1]))*$/.test(value)){
                return "出生日期格式不正确！";
            }
        }
    })
    //选择出生日期
    laydate.render({
        elem: '.userBirthday',
        format: 'yyyy-MM-dd',
        trigger: 'click',
        max : 0,
        // mark : {"0-12-15":"生日"},
        done: function(value, date){
        }
    });

    //获取省信息
    address.provinces();
    //加载地址信息，把后台的地址代码转换成地址名称
    address.loadAddress();

    //提交个人资料
    form.on("submit(changeUser)",function(data){
        var index = layer.msg('提交中，请稍候',{icon: 16,time:false,shade:0.8});
        //将填写的用户信息存到session以便下次调取
        $.post("/employeeAdd",{
            id:$("#employeeId").val(),
            birthday : $("#birthday").val(),  //生日
            phone : $("#phone").val(),  //手机
            email : $("#email").val(),    //邮箱
            gender : data.field.gender,//性别
            wedlock: data.field.wedlock,//婚姻状态
            'address.province': data.field.province,//省
            'address.city': data.field.city,//市
            'address.area': data.field.area,//区
            tiptopDegree: $("#tiptopDegree").val(),
            school:$("#school").val(),
            submitType : "edit"//提交类型
        },function(res){
            if (res.code == 201 ){
                setTimeout(function(){
                    layer.close(index);
                    layer.msg(res.msg);
                },1000);
            }else{
                setTimeout(function(){
                    layer.close(index);
                    layer.msg(res.msg);
                },1000);
            }
        })
        return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
    })

    //根据地址code找地址
    function getAddress(position,code){
        $.get("../../json/address.json", function (data) {
                if (position == 'province') {
                    for (var i = 0; i < data.length; i++) {
                        if (data[i].code == code){
                            return data[i].name
                        }
                    }
                }
        })
    }

    //修改密码
    form.on("submit(changePwd)",function(data){
        var index = layer.msg('提交中，请稍候',{icon: 16,time:false,shade:0.8});
        setTimeout(function(){
            layer.close(index);
            layer.msg("密码修改成功！");
            $(".pwd").val('');
        },2000);
        return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
    })
})