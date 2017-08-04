<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="tilesx" uri="http://tiles.apache.org/tags-tiles-extras" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div class="container">
    <div >
        <div class="container" style="width: 30%; float: left">
            <div class="row row-content">
                <div class="list-group doc-menu">
                    <a href="/moderator/cabinet" class="list-group-item navbar-inverse">
                        <spring:message code="messages.clinic" />
                    </a>
                    <a href="/moderator/cabinet/doctors" class=" list-group-item ">
                        <spring:message code="messages.doctors" /><span class="badge">${doctors.size()}</span>
                    </a>
                    <a href="/moderator/cabinet/add/doctor" class="list-group-item">
                        <spring:message code="messages.addDoctors" />
                    </a>
                </div>
            </div>
        </div>
    </div>
    <div>
        <div class="container" style="width: 70%; float: right">
            <div class="row row-content">
                <h3 class="text-center na">${moderator.clinics.clinic_name}</h3>
                <hr>
                <div class="row">
                    <div class="row">
                        <!-- left column -->
                        <div class="col-md-3 col-md-offset-1">
                            <div class="text-center">
                                <div class="image-container ">
                                <img src="data:image/jpeg;base64,${moderator.clinics.photo}" class="avatar img-circle image img-responsive "  alt="avatar" width="100%"height="100%">
                                    <div class="middle">
                                        <div class="text">Change</div>
                                    </div>
                                </div>

                                <form:form action="/moderator/upload/clinicPhoto" method="post" enctype="multipart/form-data" modelAttribute="photoForm">
                                    <div class="col-lg-7">

                                        <%--<span class="btn btn-default btn-file">--%>
                                      <%--<i class="fa fa-camera-retro" aria-hidden="true"></i> <input name="file" type="file">--%>
                                           <%--</span>--%>
                                        <%--<button type="submit">Change</button>--%>
                                            <div style="position:relative;">
                                                <a class='btn btn-file' href='javascript:;'>
                                                    Choose File...
                                                    <form:input path="multipartFile" type="file"  style='position:absolute;z-index:2;top:0;left:0;filter: alpha(opacity=0);-ms-filter:"progid:DXImageTransform.Microsoft.Alpha(Opacity=0)";opacity:0;background-color:transparent;color:transparent;' name="file_source" size="40"  onchange='$("#upload-file-info").html($(this).val());'/>
                                                </a>
                                                &nbsp;
                                                <span class='label label-info' id="upload-file-info"></span>
                                                <form:errors path="multipartFile"></form:errors>
                                                <button class='btn btn-github' style="margin-top: 5px;margin-left: 20px">Change</button>
                                            </div>

                                    </div>

                                </form:form>

                            </div>
                            <div></div>
                        </div>
                        <div class="col-md-7 personal-info">
                    <form:form method="POST" modelAttribute="clinicDTO" action="/moderator/cabinet">
                    <div class="form-group">
                        <label class="col-lg-3 control-label"><spring:message code="messages.userFirstname"/>:</label>
                        <div class="col-lg-7">
                            <form:errors path="clinic_name"></form:errors>
                            <form:input type="text" class="form-control" path="clinic_name"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label"> <spring:message code="messages.userLastname"/>:</label>
                        <div class="col-lg-7">
                            <form:textarea cssClass="form-control" path="description" value="${clinicDTO.description}"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label"><spring:message code="messages.userEmail"/>:</label>
                        <div class="col-lg-7">
                            <form:input type="text" class="form-control" path="email" value="${clinic.contact.email}" disabled="false" cssStyle="background-color: #72d9b9;"/>
                        </div>
                    </div>
                        <div class="form-group">
                        <label class="col-lg-3 control-label"><spring:message code="messages.userAddress"/>:</label>
                        <div class="col-lg-7">
                            <form:input type="text" class="form-control d" path="address" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label"><spring:message code="messages.userCity"/>:</label>
                        <div class="col-lg-7">
                            <form:input type="text" class="form-control" path="city"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label"><spring:message code="messages.userZipcode"/>:</label>
                        <div class="col-lg-7">
                            <form:input type="text" class="form-control" path="zipCode"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label"><spring:message code="messages.userFirstPhone"/>:</label>
                        <div class="col-lg-7">
                            <form:input type="text" class="form-control" path="firstPhone"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label"><spring:message code="messages.userSecondPhone"/>:</label>
                        <div class="col-lg-7">
                            <form:input type="text" class="form-control" path="secondPhone"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label"><spring:message code="messages.userThirdPhone"/>:</label>
                        <div class="col-lg-7">
                            <form:input type="text" class="form-control" path="thirdPhone"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"></label>
                        <div class="col-md-7">
                            <input type="submit" class="btn btn-clinic"
                                   value="<spring:message code="messages.saveChanges"/>">
                            <span></span>
                            <input type="reset" class="btn btn-github"
                                   value="<spring:message code="messages.cancel"/>">
                        </div>
                    </div>
                </form:form>
                        </div>
                </div>
            </div>

        </div>
    </div>
</div>
</div>