layui.use(['form','layer','table','laytpl'],function(){
    var form = layui.form,
        layer = parent.layer === undefined ? layui.layer : top.layer,
        $ = layui.jquery,
        laytpl = layui.laytpl,
        table = layui.table;

    //用户列表
    var tableIns = table.render({
        elem: '#applyList',
        url : 'applyInfo',
        cellMinWidth : 95
        ,page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
        layout: ['limit', 'count', 'prev', 'page', 'next', 'skip'] //自定义分页布局
            //,curr: 5 //设定初始在第 5 页
            ,groups: 1 //只显示 1 个连续页码
            ,first: false //不显示首页
            ,last: false //不显示尾页
        },
        height : "full-125",
        limits : [10,15,20,25],
        limit : 10,
        id : "applyList",
        cols : [[
            {type: "checkbox", fixed:"left", width:50},
            {field: 'id', title: '申请ID',  align:"center"},
            {field: 'employeeId', title: '员工号',  align:"center"},
            {field: 'name', title: '员工姓名', align:'center'},
            {field: 'type', title: '申请类型',  align:'center',templet:function(d){
                if (d.type == "1") {
                    return "签到补卡"
                }else if (d.type == "2") {
                    return "签退补卡"
                }else if (d.type == "3") {
                    return "请假"
                }else{
                    return "未知"
                }
                }},
            {field: 'remark', title: '备注信息',  align:"center"},
            {field: 'date', title: '申请日期',  align:"center"},
            {field: 'startTime', title: '开始时间',  align:"center"},
            {field: 'endTime', title: '结束时间',  align:"center"},
            {field: 'state', title: '审批状态', align:"center",templet:function(d){
                    if (d.state == 0) {
                        return "<span style='color: #FFB800;'>未审批</span>"
                    }else if (d.state == 1) {
                        return "<span style='color: #5FB878;'>审批通过</span>"
                    }else if (d.state == 2) {
                        return "<span style='color: #FF5722;'>审批未通过</span>"
                    }else{
                        return "<span style='color: #FF5722;'>未知</span>"
                    }
                }},
            {title: '操作', minWidth:175,fixed:"right",align:"center",templet:function(d){
                    if (d.state == 0) {
                        return '<a class="layui-btn layui-btn-xs" lay-event="yes">同意审批</a>'+
                            '<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="no">拒绝审批</a>'
                    }else if (d.state == 1) {
                        return "<span style='color: #5FB878;'>审批通过</span>"
                    }else if (d.state == 2) {
                        return "<span style='color: #FF5722;'>审批未通过</span>"
                    }else{
                        return "未知"
                    }
                }}
        ]]
    });

    //搜索
    $(".search_btn").on("click",function(){
            table.reload("departmentList",{
                page: {
                    curr: 1 //重新从第 1 页开始
                },
                where: {
                    depName: $(".searchVal").val(),  //搜索的关键字
                }
            })
    });

    //列表操作
    table.on('tool(applyList)', function(obj){
        var layEvent = obj.event,
            data = obj.data;
        if(layEvent === 'yes'){ //同意
            $.post("approval", {
                id: data.id,  //id
                state: 1,
                type:data.type,
                date:data.date
            },function (data) {
                layer.msg(data.msg);
            })
        }else if(layEvent === 'no'){ //不同意
            $.post("approval", {
                id: data.id,  //id
                state: 2,
                type:data.type,
                date:data.date
            },function (data) {
                layer.msg(data.msg);
            })
        }
    });

})
