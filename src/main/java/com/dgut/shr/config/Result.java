package com.dgut.shr.config;

public class Result {
    String code;
    String msg;
    Object data;

    public static final Result loginFail = new Result("100","用户名或者密码错误");
    public static final Result ADD_EMPLOYEE_REPEAT =new Result("101","该用户已经存在");
    public static final Result INPUT_ARGS_ERROR =new Result("102","输入参数错误");
    public static final Result NO_EMPLOYEE_ID =new Result("103","通过该员工号查找不到用户");
    public static final Result UPDATE_EMPLOYEE_FAIL =new Result("104","修改员工失败");
    public static final Result DELETE_EMPLOYEE_FAIL =new Result("105","删除员工失败");
    public static final Result UPDATE_DEPARTMENT_FAIL =new Result("106","修改部门失败");
    public static final Result DELETE_DEPARTMENT_FAIL =new Result("107","删除部门失败");
    public static final Result ADD_DEPARTMENT_REPEAT =new Result("108","该部门已经存在");
    public static final Result NO_DEPARTMENT_ID =new Result("109","通过该部门号查找不到部门");
    public static final Result POSITION_OPERATION_FAIL =new Result("110","职位操作失败");
    public static final Result SIGN_IN_FAIL =new Result("111","签到失败");
    public static final Result SIGN_OUT_FAIL =new Result("112","签退失败");

    public static final Result loginSuccess = new Result("200","登陆成功");
    public static final Result ADD_EMPLOYEE_SUCCESS = new Result("201","添加用户成功");
    public static final Result FIND_EMPLOYEE_SUCCESS = new Result("202","成功找到该员工");
    public static final Result UPDATE_EMPLOYEE_SUCCESS =new Result("203","修改员工成功");
    public static final Result DELETE_EMPLOYEE_SUCCESS =new Result("204","删除员工成功");
    public static final Result UPDATE_DEPARTMENT_SUCCESS =new Result("205","修改部门成功");
    public static final Result DELETE_DEPARTMENT_SUCCESS =new Result("206","删除部门成功");
    public static final Result ADD_DEPARTMENT_SUCCESS = new Result("207","添加部门成功");
    public static final Result FIND_DEPARTMENT_SUCCESS = new Result("208","成功找到该部门");
    public static final Result POSITION_OPERATION_SUCCESS =new Result("209","职位操作成功");
    public static final Result SIGN_IN_SUCCESS =new Result("210","签到成功");
    public static final Result SIGN_OUT_SUCCESS =new Result("211","签退成功");

    public Result(String code, String msg) {
        this.code = code;
        this.msg = msg;
    }
    public Result(String code, String msg,Object data) {
        this.code = code;
        this.msg = msg;
        this.data = data;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}
