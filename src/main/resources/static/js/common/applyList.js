layui.use(['form', 'layer', 'table', 'laytpl'], function () {
    var form = layui.form,
        layer = parent.layer === undefined ? layui.layer : top.layer,
        $ = layui.jquery,
        laytpl = layui.laytpl,
        table = layui.table;

    //用户列表
    var tableIns = table.render({
        elem: '#applyList',
        url: '/commonApply/applyInfo',
        cellMinWidth: 95,
        page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
            layout: ['limit', 'count', 'prev', 'page', 'next', 'skip'] //自定义分页布局
            , groups: 1 //只显示 1 个连续页码
            , first: false //不显示首页
            , last: false //不显示尾页
        },
        height: "full-125",
        limits: [10, 15, 20, 25],
        limit: 10,
        id: "applyList",
        cols: [[
            {field: 'id', title: '申请ID', align: "center"},
            {field: 'employeeId', title: '员工号', align: "center"},
            {field: 'name', title: '员工姓名', align: 'center'},
            {
                field: 'type', title: '申请类型', align: 'center', templet: function (d) {
                    if (d.type == "1") {
                        return "签到补卡"
                    } else if (d.type == "2") {
                        return "签退补卡"
                    } else if (d.type == "3") {
                        return "请假"
                    }else if (d.type == "4") {
                        return "离职"
                    } else {
                        return "未知"
                    }
                }
            },
            {field: 'remark', title: '备注信息', align: "center"},
            {field: 'date', title: '申请时间', align: "center"},
            {
                field: 'startTime', title: '开始时间', align: "center", templet: function (d) {
                    return d.startTime.substr(0,11)
                }
            },
            {
                field: 'endTime', title: '结束时间', align: "center", templet: function (d) {
                    return d.endTime.substr(0,11)
                }
            },
            {
                field: 'state', title: '审批状态', align: "center", templet: function (d) {
                    if (d.state == 0) {
                        return "<span style='color: #FFB800;'>未审批</span>"
                    } else if (d.state == 1) {
                        return "<span style='color: #5FB878;'>审批通过</span>"
                    } else if (d.state == 2) {
                        return "<span style='color: #FF5722;'>审批未通过</span>"
                    } else {
                        return "<span style='color: #FF5722;'>未知</span>"
                    }
                }
            }
        ]]
    });

    //搜索
    $(".search_btn").on("click", function () {
        table.reload("applyList", {
            page: {
                curr: 1 //重新从第 1 页开始
            },
            where: {
                empName: $("#empName").val(),  //搜索的关键字
                applyState: $("#select option:selected").val()
            }
        })
    });

    //列表操作
    table.on('tool(applyList)', function (obj) {
        var layEvent = obj.event,
            data = obj.data;
        if (layEvent === 'yes') { //同意
            $.post("approval", {
                id: data.id,  //id
                state: 1,
                type: data.type,
                date: data.date
            }, function (data) {
                layer.msg(data.msg);
            })
        } else if (layEvent === 'no') { //不同意
            $.post("approval", {
                id: data.id,  //id
                state: 2,
                type: data.type,
                date: data.date
            }, function (data) {
                layer.msg(data.msg);
            })
        }
    });
    //格式化日期
    Date.prototype.Format = function (fmt) { //author: meizz
        var o = {
            "M+": this.getMonth() + 1, //月份
            "d+": this.getDate(), //日
            "h+": this.getHours(), //小时
            "m+": this.getMinutes(), //分
            "s+": this.getSeconds(), //秒
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度
            "S": this.getMilliseconds() //毫秒
        };
        if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    }

})
