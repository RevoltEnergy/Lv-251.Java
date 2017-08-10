package com.softserve.edu.lv251.dto.pojos;

import com.softserve.edu.lv251.entity.Appointments;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by User on 02.08.2017.
 */
public class AppointmentsDTO {


    private Long id;
    private String title;
    private String start;
    private String color;

    public  AppointmentsDTO(){}


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getStart() {
        return start;
    }

    public void setStart(String start) {
        this.start = start;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }


}
