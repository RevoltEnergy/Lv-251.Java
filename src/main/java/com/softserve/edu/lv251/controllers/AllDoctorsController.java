package com.softserve.edu.lv251.controllers;

import com.softserve.edu.lv251.constants.Constants;
import com.softserve.edu.lv251.dto.pojos.DoctorsSearchDTO;
import com.softserve.edu.lv251.entity.Appointments;
import com.softserve.edu.lv251.entity.Doctors;
import com.softserve.edu.lv251.service.AppointmentService;
import com.softserve.edu.lv251.service.DoctorsService;
import com.softserve.edu.lv251.service.PagingSizeService;
import com.softserve.edu.lv251.service.UserService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;

/**
 * Created by Yana Martynyak on 23.07.2017.
 * Updated: Brynetskyi Marian
 */
@Controller
public class AllDoctorsController {

    @Autowired
    private DoctorsService doctorsService;
    @Autowired
    @Qualifier("doctorService")
    private PagingSizeService<Doctors> pagingSizeService;
    @Autowired
    private UserService userService;
    @Autowired
    private AppointmentService appointmentService;
    @Autowired
    private Logger logger;


    @RequestMapping(value = "/allDoctors/{current}", method = RequestMethod.GET)
    public String allDoctors(@PathVariable("current") Integer chainIndex, Model model) {
        model.addAttribute(Constants.Controllers.GET_DOCTORS, pagingSizeService.getEntity(chainIndex, 10));
        model.addAttribute(Constants.Controllers.NUMBER_CHAIN, pagingSizeService.numberOfPaging(10));
        model.addAttribute(Constants.Controllers.DOC_APPS, appointmentService.getAllDoctorsAppointmentsAfterNow());
        return Constants.Controllers.ALL_DOCTORS;
    }

    /**
     * Created by Marian Brynetskyi
     *
     * @param modelMap   - model
     * @param localdate  - date of ppointment
     * @param doctorId   - docId with wrong date
     * @param chainIndex - id of page
     * @param principal  - user
     * @return
     */
    @RequestMapping(value = "/user/addAppointment", method = RequestMethod.POST)
    public ModelAndView addAppointment(Model modelMap, @RequestParam("datetime") String localdate,
                                       @RequestParam(Constants.Controllers.DOCTOR_ID) long doctorId,
                                       @RequestParam(Constants.Controllers.CURRENT) Integer chainIndex, Principal principal) {
        Date date;

        ModelAndView modelAndView = new ModelAndView();
        try {

            SimpleDateFormat isoFormat = new SimpleDateFormat("dd/MM/yyyy - HH:mm");
            isoFormat.setTimeZone(TimeZone.getTimeZone("UTC"));
            date = isoFormat.parse(localdate);

            if (date.before(new Date())) {
                throw new Exception();
            }
            Appointments appointments = new Appointments();
            appointments.setAppointmentDate(date);
            appointments.setIsApproved(false);
            appointments.setUsers(userService.findByEmail(principal.getName()));
            appointments.setDoctors(doctorsService.find(doctorId));
            appointmentService.addAppointment(appointments);

        } catch (Exception e) {
            logger.info("Wrong date.", e);
            modelAndView.addObject(Constants.Controllers.DATE_FLAG, true);
            modelAndView.addObject("doc", doctorId);

            modelAndView.setViewName("redirect:/" + allDoctors(chainIndex, modelMap) + "/" + chainIndex);
            return modelAndView;
        }

        modelAndView.setViewName("redirect:/" + allDoctors(chainIndex, modelMap) + "/" + chainIndex);
        return modelAndView;
    }
    

    @RequestMapping(value = "/doctors/{id}", method = RequestMethod.GET)
    public String Doctor(@PathVariable Long id, Model model) {
        model.addAttribute("doctor", doctorsService.find(id));
        return "doctor_details";
    }

}
