layui.use(['element','slider','form','table'], function () {
    var $ = layui.jquery
        , element = layui.element,//Tab的切换功能，切换事件监听等，需要依赖element模块
            slider = layui.slider,
     form = layui.form,
    table = layui.table;


    //计算工资
    $("#calculateSalaryBtn").on("click",function(){
        $.post("calculateSalary", {
        },function (data) {
            layer.msg(data.msg);
        })
    })

    //加班时长工资按照正常工资的多少倍计算
    var workHour = 0
    //加班设置按钮
    $("#setWorkHourBtn").on("click",function(){
        $.post("workOverTimeSetting", {
            number: workHour,  //id
        },function (data) {
            layer.msg(data.msg);
        })
    })

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
    //用户列表
    var tableIns = table.render({
        elem: '#employeeList',
        url : '/employeeInfo',
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
            {field: 'id', title: '工号',  align:"center"},
            {field: 'name', title: '姓名',  align:"center"},
            {field: 'positionName', title: '职位', align:'center'},
            {field: 'depName', title: '所属部门', align:'center'},
            {field: 'workState', title: '用户状态',  align:'center',templet:function(d){
                    return d.workState == "1" ? "在职" : "离职";
                }},
        ]]
    });

    var monthSalary = 0
    $("#allAddBtn").click(function () {
        var bonus
        if ($("#type input:checked").val() == 1){
            bonus = monthSalary
        }else{
            bonus = $("#bonus").val()
        }
        $.post("depBonusSetting", {
            departmentId: $("#department option:selected").val(),
            type: $("#type input:checked").val(),
            bonus:bonus
        },function (data) {
            layer.msg(data.msg);
        })
    })

    $("#empAddBtn").click(function () {
        var bonus = $("#empBonus").val()
        var checkStatus = table.checkStatus('employeeList'),
            data = checkStatus.data,
            ids = [];

        if(data.length > 0) {
            for (var i in data) {
                ids.push(data[i].id);
            }
            $.post("empBonusSetting", {
                ids: ids,
                bonus:bonus
            },function (data) {
                layer.msg(data.msg);
            })

        } else{
            layer.msg("请选择要发放奖金的员工")
        }
    })

    form.on('radio(levelM)', function(data){
        var val = data.value;
        console.log(val)
        if (val == 1){
            $("#item1").show()
            $("#item2").hide()
        }else{
            $("#item2").show()
            $("#item1").hide()
        }
        console.log(data.value); //被点击的radio的value值
    });

    //设置步长
    slider.render({
        elem: '#overWorkHour'
        ,step: 0.5 //步长
        ,max:3
        ,input: true //输入框,
        ,value:$("#curWorkOver").val()
        ,change: function (value) {
            workHour = value
        }
    });
    //设置步长
    slider.render({
        elem: '#monthSalary'
        ,step: 1 //步长
        ,max:5
        ,input: true //输入框
        ,change: function(value){
            monthSalary = value
        }
    });
    //触发事件
    var active = {
        tabAdd: function () {
            //新增一个Tab项
            element.tabAdd('demo', {
                title: '新选项' + (Math.random() * 1000 | 0) //用于演示
                , content: '内容' + (Math.random() * 1000 | 0)
                , id: new Date().getTime() //实际使用一般是规定好的id，这里以时间戳模拟下
            })
        }
        , tabDelete: function (othis) {
            //删除指定Tab项
            element.tabDelete('demo', '44'); //删除：“商品管理”
            othis.addClass('layui-btn-disabled');
        }
        , tabChange: function () {
            //切换到指定Tab项
            element.tabChange('demo', '22'); //切换到：用户管理
        }
    };

    $('.site-demo-active').on('click', function () {
        var othis = $(this), type = othis.data('type');
        active[type] ? active[type].call(this, othis) : '';
    });

    //Hash地址的定位
    var layid = location.hash.replace(/^#test=/, '');
    element.tabChange('test', layid);
    element.on('tab(test)', function (elem) {
        location.hash = 'test=' + $(this).attr('lay-id');
    });

});