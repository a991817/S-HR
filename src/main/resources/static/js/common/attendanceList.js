layui.use(['form', 'layer', 'table', 'laytpl', 'laydate'], function () {
    var form = layui.form,
        layer = parent.layer === undefined ? layui.layer : top.layer,
        $ = layui.jquery,
        laytpl = layui.laytpl,
        laydate = layui.laydate,
        table = layui.table;

    laydate.render({
        elem: '#endTime',
        format: 'yyyy-MM-dd',
        trigger: 'click',
        // mark : {"0-12-15":"生日"},
        done: function (value, date) {
        }
    });
    laydate.render({
        elem: '#startTime',
        format: 'yyyy-MM-dd',
        trigger: 'click',
        // mark : {"0-12-15":"生日"},
        done: function (value, date) {
        }
    });

    //用户列表
    var tableIns = table.render({
        elem: '#attendanceList',
        url: 'attendanceInfo',
        cellMinWidth: 95
        , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
            layout: ['limit', 'count', 'prev', 'page', 'next', 'skip'] //自定义分页布局
            //,curr: 5 //设定初始在第 5 页
            , groups: 1 //只显示 1 个连续页码
            , first: false //不显示首页
            , last: false //不显示尾页
        },
        height: "full-125",
        limits: [10, 15, 20, 25],
        limit: 10,
        id: "attendanceList",
        cols: [[
            {field: 'employeeId', title: '员工号', align: "center"},
            {field: 'date', title: '日期', align: "center"},
            {field: 'signInTime', title: '签到时间', align: 'center'},
            {field: 'signOutTime', title: '签退时间', align: "center"},
            {field: 'workHours', title: '工作时间', align: "center"},
            {field: 'overtimeHours', title: '加班时长', align: "center"},
            {
                field: 'state', title: '状态', align: "center", templet: function (d) {
                    if (d.state == "正常") {
                        return "<span style='color: #5FB878;'>正常</span>"
                    } else{
                        return "<span style='color: #ff0000;'>"+d.state+"</span>"
                    }
                }
            },
            {
                title: '操作', minWidth: 175, fixed: "right", align: "center", templet: function (d) {
                    if (d.state.indexOf("正常") >= 0) {
                        return "<span style='color: #5FB878;'>正常</span>"
                    } else if (d.state.indexOf("迟到") >= 0 && d.state.indexOf("早退") >= 0) {
                        return "<a class=\"layui-btn layui-btn-xs\" lay-event=\"reSignIn\">签到补卡</a>\n" +
                            "        <a class=\"layui-btn layui-btn-xs\" lay-event=\"reSignOut\">签退补卡</a>"
                    } else if (d.state.indexOf("迟到") >= 0) {
                        return "<a class=\"layui-btn layui-btn-xs\" lay-event=\"reSignIn\">签到补卡</a>"
                    } else {
                        return " <a class=\"layui-btn layui-btn-xs\" lay-event=\"reSignOut\">签退补卡</a>"
                    }
                }
            }
        ]]
    });

    //搜索
    $(".search_btn").on("click", function () {
        table.reload("attendanceList", {
            page: {
                curr: 1 //重新从第 1 页开始
            },
            where: {
                startTime: $("#startTime").val(),  //搜索的关键字
                endTime: $("#endTime").val()
            }
        })
    });


    //列表操作
    table.on('tool(attendanceList)', function (obj) {
        var layEvent = obj.event,
            data = obj.data;
        if (layEvent == 'reSignIn') { //补卡
            if (data.state.indexOf("迟到") < 0) {
                layer.msg("签到信息正常")
            } else {
                layer.prompt({title: '输入备注信息', formType: 2}, function (remark, index) {
                    console.log(data)
                    $.get("/commonApply/addApply", {
                        id: data.id,  //id
                        remark: remark,
                        type: 1,
                        startTime: data.signInTime,
                        endTime: data.signInTime
                    }, function (data) {
                        layer.close(index);
                        if (data.code == 212) {
                            layer.msg(data.msg)
                        } else {
                            layer.msg(data.msg);
                        }
                    })
                })
            }
        } else if (layEvent == 'reSignOut') {
            if (data.state.indexOf("早退") < 0) {
                layer.msg("签退信息正常")
            } else {
                layer.prompt({title: '输入备注信息', formType: 2}, function (remark, index) {
                    $.get("/commonApply/addApply", {
                        id: data.id,  //id
                        remark: remark,
                        type: 2,
                        startTime: data.signInTime,
                        endTime: data.signInTime
                    }, function (data) {
                        layer.close(index);
                        if (data.code == 212) {
                            layer.msg(data.msg)
                        } else {
                            layer.msg(data.msg);
                        }
                    })
                })
            }
        }
    });

})
