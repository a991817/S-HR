//获取系统时间
var newDate = '';
getLangDate();
//值小于10时，在前面补0
function dateFilter(date){
    if(date < 10){return "0"+date;}
    return date;
}
function getLangDate(){
    var dateObj = new Date(); //表示当前系统时间的Date对象
    var year = dateObj.getFullYear(); //当前系统时间的完整年份值
    var month = dateObj.getMonth()+1; //当前系统时间的月份值
    var date = dateObj.getDate(); //当前系统时间的月份中的日
    var day = dateObj.getDay(); //当前系统时间中的星期值
    var weeks = ["星期日","星期一","星期二","星期三","星期四","星期五","星期六"];
    var week = weeks[day]; //根据星期值，从数组中获取对应的星期字符串
    var hour = dateObj.getHours(); //当前系统时间的小时值
    var minute = dateObj.getMinutes(); //当前系统时间的分钟值
    var second = dateObj.getSeconds(); //当前系统时间的秒钟值
    var timeValue = "" +((hour >= 12) ? (hour >= 18) ? "晚上" : "下午" : "上午" ); //当前时间属于上午、晚上还是下午
    newDate = dateFilter(year)+"年"+dateFilter(month)+"月"+dateFilter(date)+"日 "+" "+dateFilter(hour)+":"+dateFilter(minute)+":"+dateFilter(second);
    // document.getElementById("nowTime").innerHTML = "亲爱的超级管理员，"+timeValue+"好！ 欢迎使用人力资源管理系统。当前时间为： "+newDate+"　"+week;
    setTimeout("getLangDate()",1000);
}

Date.prototype.format =function(format)
{
    var o = {
        "M+" : this.getMonth()+1, //month
        "d+" : this.getDate(), //day
        "h+" : this.getHours(), //hour
        "m+" : this.getMinutes(), //minute
        "s+" : this.getSeconds(), //second
        "q+" : Math.floor((this.getMonth()+3)/3), //quarter
        "S" : this.getMilliseconds() //millisecond
    }
    if(/(y+)/.test(format)) format=format.replace(RegExp.$1,
        (this.getFullYear()+"").substr(4- RegExp.$1.length));
    for(var k in o)if(new RegExp("("+ k +")").test(format))
        format = format.replace(RegExp.$1,
            RegExp.$1.length==1? o[k] :
                ("00"+ o[k]).substr((""+ o[k]).length));
    return format;
}

layui.use(['form','element','layer','jquery'],function(){
    var form = layui.form,
        layer = parent.layer === undefined ? layui.layer : top.layer,
        element = layui.element;
        $ = layui.jquery;

    //    领导
    $("#leader").click(function(){
        layer.open({
            type: 2,
            title: '领导信息',
            skin: 'layui-layer-demo', //样式类名
            closeBtn: 0, //不显示关闭按钮
            anim: 2,
            shadeClose: true, //开启遮罩关闭
            content: 'leaderInfo'
        });
    })



    //    加载后
    $(document).ready(function(){
        var signInTime = $("#signInTime").val()
        var signOutTime = $("#signOutTime").val()
        //签到
        if ($("#signInState").val() != null && $("#signInState").val() != '未签到') {
            //改变按钮样式
            $("#signInBtn").attr('disabled',true);
            $("#signInBtn").addClass("layui-disabled")
            //设置签到时间
            $("#signInStateh1").text(signInTime)
            //设置签到状态
            $("#signInStateText").text($("#signInState").val())
        }else{
            $("#signInStateh1").text("未签到")
            $("#signInStateText").text("未签到")
        }
        //签退
        if ($("#signInState").val() != null && $("#signOutState").val() != '未签退') {
            $("#signOutBtn").attr('disabled',true);
            $("#signOutBtn").addClass("layui-disabled")
            $("#signOutStateh1").text(signOutTime)
            $("#signOutStateText").text($("#signOutState").val())
        }else{
            $("#signOutStateh1").text("未签退")
            $("#signOutStateText").text("未签退")
        }
    //    工作时长
        if ($("#workTime").val() !=null && $("#workTime").val() != ''){
            $("#workTimeh1").text($("#workTime").val() + "小时")
            //判断是否做满8小时
            if ($("#workTime").val() > 8) {
                $("#workTimetext").text("正常")
            }else{
                $("#workTimetext").text("异常")
            }
            //显示进度条
            var percent =$("#workTime").val() / 8;
            element.progress('demo', percent*100 + '%')
        }else{
            $("#workTimeh1").text(0 + "小时")
            element.progress('demo', '0%')
        }
        setBeginDate();
    })

    //设置在职多久了
    function setBeginDate(){
        var beginDate = $("#beginDate").val().split("-")
        var cur = new Date()
        var year = cur.getFullYear() - beginDate[0]
        var month = cur.getMonth() - beginDate[1]+1
        var date = cur.getDate() - beginDate[2]
        $("#year").text(year)
        $("#month").text(month)
        $("#date").text(date)
    }
    //签到
    $("#signInBtn").on("click",function(){
        $.ajax({
            url : "/attendance/signIn",
            type : "post",
            dataType : "json",
            success : function(data){
                if (data.code == 200) {
                    $("#signInBtn").attr('disabled',true);
                    $("#signInBtn").addClass("layui-disabled")
                    //设置签到时间
                    $("#signInStateh1").text(data.data.signInTime)
                    //设置签到状态
                    $("#signInStateText").text(data.data.signInState)
                    layer.msg("签到成功")
                }else{
                    layer.msg("签到失败")
                }
            }
        })
    })

    //签退
    $("#signOutBtn").on("click",function(){
        $.ajax({
            url : "/attendance/signOut",
            type : "post",
            dataType : "json",
            success : function(data){
                if (data.code == 200) {
                    $("#signOutBtn").attr('disabled',true);
                    $("#signOutBtn").addClass("layui-disabled")
                    $("#signOutStateh1").text(data.data.signOutTime)
                    $("#signOutStateText").text(data.data.signOutState)
                    $("#workTimeh1").text(data.data.workHours)
                    layer.msg("签退成功")
                }else{
                    layer.msg("签退失败")
                }
            }
        })
    })

    //请假
    function leave(){
        var index = layui.layer.open({
            title : "请假申请",
            type : 2,
            content : "/commonApply/leavePage",
            success : function(layero, index){
                var body = layui.layer.getChildFrame('body', index);
                setTimeout(function(){
                    layui.layer.tips('点击此处返回', '.layui-layer-setwin .layui-layer-close', {
                        tips: 3
                    });
                },500)
            }
        })
        layui.layer.full(index);
        window.sessionStorage.setItem("index",index);
        //改变窗口大小时，重置弹窗的宽高，防止超出可视区域（如F12调出debug的操作）
        $(window).on("resize",function(){
            layui.layer.full(window.sessionStorage.getItem("index"));
        })
    }

    //离职申请
    function quit(){
        var index = layui.layer.open({
            title : "离职申请",
            type : 2,
            content : "/commonApply/quitPage",
            success : function(layero, index){
                var body = layui.layer.getChildFrame('body', index);
                setTimeout(function(){
                    layui.layer.tips('点击此处返回', '.layui-layer-setwin .layui-layer-close', {
                        tips: 3
                    });
                },500)
            }
        })
        layui.layer.full(index);
        window.sessionStorage.setItem("index",index);
        //改变窗口大小时，重置弹窗的宽高，防止超出可视区域（如F12调出debug的操作）
        $(window).on("resize",function(){
            layui.layer.full(window.sessionStorage.getItem("index"));
        })
    }

    //请假点击
    $("#leaveBtn").on("click",function(){
        leave()
    })
    //离职点击
    $("#quitBtn").on("click",function(){
        quit()
    })


})
