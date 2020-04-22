layui.use(['form','layer','table','laytpl'],function(){
    var form = layui.form,
        layer = parent.layer === undefined ? layui.layer : top.layer,
        $ = layui.jquery,
        laytpl = layui.laytpl,
        table = layui.table;

    //用户列表
    var tableIns = table.render({
        elem: '#employeeList',
        url : 'employeeInfo',
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
        id : "employeeList",
        cols : [[
            {type: "checkbox", fixed:"left", width:50},
            {field: 'name', title: '姓名',  align:"center"},
            {field: 'id', title: '工号',  align:"center"},
            {field: 'gender', title: '性别', align:'center'},
            {field: 'phone', title: '手机号',  align:"center"},
            {field: 'email', title: '邮箱',  align:"center"},
            {field: 'positionName', title: '职位', align:'center'},
            {field: 'depName', title: '所属部门', align:'center'},
            {field: 'workState', title: '用户状态',  align:'center',templet:function(d){
                return d.workState == "1" ? "在职" : "离职";
            }},
            {title: '操作', minWidth:175, templet:'#userListBar',fixed:"right",align:"center"}
        ]]
    });

    //搜索
    $(".search_btn").on("click",function(){
        if($(".searchVal").val() != '' && $("#select option:selected").val()!=''){
            table.reload("employeeList",{
                page: {
                    curr: 1 //重新从第 1 页开始
                },
                where: {
                    key: $(".searchVal").val(),  //搜索的关键字
                    select: $("#select option:selected").val()
                }
            })
        }else{
            layer.msg("请输入搜索的内容");
        }
    });

    //添加用户
    function addEmployee(edit){
        var index = layui.layer.open({
            title : "添加员工",
            type : 2,
            content : "employeeAddPage",
            success : function(layero, index){
                var body = layui.layer.getChildFrame('body', index);
                if(edit){
                    body.find("#name").val(edit.data.name);  //姓名
                    body.find("#employeeId").val(edit.data.id);
                    body.find("#idNumber").val(edit.data.idNumber);
                    body.find("#birthday").val(edit.data.birthday);
                    body.find("#phone").val(edit.data.phone);
                    body.find("#email").val(edit.data.email);
                    body.find("#nativePlace").val(edit.data.nativePlace);
                    body.find("#basicSalary").val(edit.data.basicSalary);
                    if (edit.data.gender == '男') {
                        body.find("#gender option[value='0']").attr("selected", true);
                    }else{
                        body.find("#gender option[value='1']").attr("selected", true);
                    }

                    body.find("#wordState option[value="+edit.data.workState+"]").attr("selected", true);

                    if (edit.data.wedlock == '未婚') {
                        body.find("#wedlock option[value='0']").attr("selected", true);
                    }else{
                        body.find("#wedlock option[value='1']").attr("selected", true);
                    }
                    body.find("#department option[value="+edit.data.departmentId+"]").attr("selected", true);
                    body.find("#position option[value="+edit.data.positionId+"]").attr("selected", true);
                    //提交类型
                    body.find("#submitType").val("edit");
                    body.find("#okBtn").text("修改");

                    form.render();
                }else{
                    //提交类型
                    body.find("#submitType").val("add");
                    body.find("#okBtn").text("添加");
                }

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


    $(".addNews_btn").click(function(){
        addEmployee();
    })

    //批量删除
    $(".delAll_btn").click(function(){
        var checkStatus = table.checkStatus('employeeList'),
            data = checkStatus.data,
            ids = [];
        if(data.length > 0) {
            for (var i in data) {
                ids.push(data[i].id);
            }
            console.log(ids)
            layer.confirm('确定删除选中的员工？', {icon: 3, title: '提示信息'}, function (index) {
                $.get("deleteEmployeeMany",{
                    ids : ids  //将需要删除的newsId作为参数传入
                },function(data){
                    layer.msg(data.msg);
                    tableIns.reload();
                    layer.close(index);
                })
            })
        }else{
            layer.msg("请选择需要删除的用户");
        }
    })

    //列表操作
    table.on('tool(employeeList)', function(obj){
        var layEvent = obj.event,
            data = obj.data;

        if(layEvent === 'edit'){ //编辑
            $.get("getEmployeeById", {
                id: data.id,  //id
                idNumber: $("#idNumber").val(),  //身份证
            },function (data) {
                console.log(data)
                if (data.code == 202) {
                    addEmployee(data);
                }else{
                    layer.msg(data.msg);
                }
            })
        }else if(layEvent === 'del'){ //删除
            layer.confirm('确定删除此员工？',{icon:3, title:'提示信息'},function(index){
                $.get("deleteEmployeeById",{
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
