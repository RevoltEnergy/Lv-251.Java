package com.softserve.edu.lv251.validators;

import com.softserve.edu.lv251.customannotations.PasswordMatches;
import com.softserve.edu.lv251.customannotations.PasswordMatchesForDoctors;
import com.softserve.edu.lv251.dto.pojos.DoctorDTO;
import com.softserve.edu.lv251.dto.pojos.UserDTO;
import com.softserve.edu.lv251.entity.Doctors;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import java.lang.annotation.Annotation;

/**
 * Created by Admin on 02.08.2017.
 */
public class DoctorsPasswordMatchesValidator implements ConstraintValidator<PasswordMatchesForDoctors,Object> {
    @Override
    public void initialize(PasswordMatchesForDoctors annotation) {

    }

    @Override
    public boolean isValid(Object obj, ConstraintValidatorContext constraintValidatorContext) {
        DoctorDTO user = (DoctorDTO) obj;
        return user.getPassword().equals(user.getMatchingPassword());
    }
}