package com.dgut.shr.config;

public class Result {
    String code;
    String msg;

    public static final Result loginFail = new Result("001","用户名或者密码错误");
    public static final Result loginSuccess = new Result("002","登陆成功");

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
