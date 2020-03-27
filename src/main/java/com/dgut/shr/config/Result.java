package com.dgut.shr.config;

public class Result {
    String code;
    String msg;

    public static final Result loginFail = new Result("100","用户名或者密码错误");
    public static final Result ADD_EMPLOYEE_REPEAT =new Result("101","该用户已经存在");
    public static final Result INPUT_ARGS_ERROR =new Result("102","输入参数错误");

    public static final Result loginSuccess = new Result("200","登陆成功");
    public static final Result ADD_EMPLOYEE_SUCCESS = new Result("201","添加用户成功");

    public Result(String code, String msg) {
        this.code = code;
        this.msg = msg;
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
}
