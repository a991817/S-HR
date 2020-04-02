layui.use(['form','layer','table','laytpl'],function(){
    var form = layui.form,
        layer = parent.layer === undefined ? layui.layer : top.layer,
        $ = layui.jquery,
        laytpl = layui.laytpl,
        table = layui.table;

    //用户列表
    var tableIns = table.render({
        elem: '#departmentList',
        url : 'departmentInfo',
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
        id : "departmentList",
        cols : [[
            {type: "checkbox", fixed:"left", width:50},
            {field: 'id', title: '部门ID',  align:"center"},
            {field: 'depName', title: '部门名称',  align:"center"},
            {field: 'numberOfPeople', title: '部门人数', align:'center'},
            {field: 'leaderName', title: '部门领导',  align:"center"},
            {title: '操作', minWidth:175, templet:'#userListBar',fixed:"right",align:"center"}
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

    //编辑部门
    function addDepartment(edit){
        var index = layui.layer.open({
            title : "添加部门",
            type : 2,
            content : "departmentAddPage/"+edit.data.id,
            success : function(layero, index){
                var body = layui.layer.getChildFrame('body', index);
                    body.find("#departmentId").val(edit.data.id);  //部门ID
                    body.find("#depName").val(edit.data.depName);
                    body.find("#leaderName").val(edit.data.leaderId);
                    body.find("#leaderName option[value="+edit.data.leaderId+"]").attr("selected", true);
                    form.render();
                setTimeout(function(){
                    layui.layer.tips('点击此处返回用户列表', '.layui-layer-setwin .layui-layer-close', {
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


    $(".addDep_btn").click(function(){
        // addDepartment();
        $(".addDepName").val()
        $.post("departmentAdd", {
            depName: $(".addDepName").val()
        },function (data) {
            console.log(data)
            if (data.code == 207) {
                layer.msg(data.msg);
                tableIns.reload();
            }else{
                layer.msg(data.msg);
            }
        })
    })

    //批量删除
    $(".delAll_btn").click(function(){
        var checkStatus = table.checkStatus('departmentList'),
            data = checkStatus.data,
            ids = [];

        if(data.length > 0) {
            for (var i in data) {
                ids.push(data[i].id);
            }
            console.log(ids)
            layer.confirm('确定删除选中的员工？', {icon: 3, title: '提示信息'}, function (index) {
                $.get("deleteDepartmentMany",{
                    ids : ids  //将需要删除的newsId作为参数传入
                },function(data){
                    layer.msg(data.msg);
                    tableIns.reload();
                    layer.close(index);
                })
            })
        }else{
            layer.msg("请选择需要删除的部门");
        }
    })

    //列表操作
    table.on('tool(departmentList)', function(obj){
        var layEvent = obj.event,
            data = obj.data;
        if(layEvent === 'edit'){ //编辑
            $.get("getDepartmentById", {
                id: data.id,  //id
            },function (data) {
                console.log(data)
                if (data.code == 208) {
                    addDepartment(data);
                }else{
                    layer.msg(data.msg);
                }
            })
        }else if(layEvent === 'del'){ //删除
            layer.confirm('确定删除此部门？',{icon:3, title:'提示信息'},function(index){
                $.get("deleteDepartmentById",{
                    id : data.id  //将需要删除的Id作为参数传入
                },function(data){
                    layer.msg(data.msg);
                    tableIns.reload();
                    layer.close(index);
                })
            });
        }
    });

})
