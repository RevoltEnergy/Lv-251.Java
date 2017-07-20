package com.softserve.edu.lv251.dao.impl;

import com.softserve.edu.lv251.dao.TestsDAO;
import com.softserve.edu.lv251.entity.Tests;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;

/**
 * Created by kilopo on 13.07.2017.
 */
@Transactional
@Repository
public class TestsDAOImpl extends BaseDAOImpl<Tests> implements TestsDAO{
}