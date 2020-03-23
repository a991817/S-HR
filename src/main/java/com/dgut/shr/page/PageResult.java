package com.dgut.shr.page;

import lombok.Data;

import java.util.List;

@Data
public class PageResult {
    private int code;

    private String msg;

    private int count;

    private List data;

}
