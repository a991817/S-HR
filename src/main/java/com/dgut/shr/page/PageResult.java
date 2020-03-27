package com.dgut.shr.page;

import lombok.Data;

import java.util.List;

@Data
public class PageResult {
    private int code;

    private String msg;

    private long count;

    private List data;

}
