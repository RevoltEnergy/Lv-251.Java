<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<link href="<c:url value="/resources/css/medicalCard.css"/>" rel="stylesheet">

<div class="container">
    <div>
        <div class="container" style="width: 30%; float: left">
            <div class="row row-content">
                <div class="list-group doc-menu">
                    <a href="<c:url value="/user/cabinet"/>" class="list-group-item">
                        <spring:message code="messages.profile"/>
                    </a>
                    <a href="#" class="list-group-item">
                        <spring:message code="messages.doctors"/>
                    </a>
                    <a href="<c:url value="/user/medicalcard"/>" class="navbar-inverse list-group-item">
                        <spring:message code="messages.medicalCard"/>
                    </a>
                </div>
            </div>
        </div>

        <div class="container" style="width: 70%; float: right">
            <div class="row row-content">

                <div class="container-fluid">
                    <div class="row content">
                        <br>
                            <div id="menu_mcard" style="cursor: pointer">
                                <ul>
                                    <li><a id="appointmentsHistoryLink" class="active list-group-item"><spring:message code="messages.appointmentsHistory"/></a></li>
                                    <li><a id="pendingAppointmentsLink" class="list-group-item"><spring:message code="messages.pendingAppointments"/></a></li>
                                </ul>
                            </div>
                        <div class="col-sm-9" style="width: 100%">
                            <div id="shown_if_not_empty" class="well mcard_content">
                                <c:set var="listPastAppointmentsLength" value="0"/>
                                <c:set var="listPendingAppointmentsLength" value="0"/>
                                <c:forEach items="${listAppointments}" var="appointment" varStatus="loop">
                                    <fmt:formatDate var="aDate" pattern = 'dd-MM-yyyy HH:mm' value='${appointment.appointmentDate}'/>
                                    <c:choose>
                                        <c:when test="${appointment.appointmentDate < date}">
                                            <c:set var="showAppointmentClass" value="appointmentsHistory"/>
                                            <c:set var="listPastAppointmentsLength" value="${listPastAppointmentsLength + 1}"/>
                                        </c:when>
                                        <c:when test="${appointment.appointmentDate >= date}">
                                            <c:set var="showAppointmentClass" value="pendingAppointments"/>
                                            <c:set var="listPendingAppointmentsLength" value="${listPendingAppointmentsLength + 1}"/>
                                        </c:when>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${appointment.appointmentDate > date && !appointment.isApproved}">
                                            <c:set var="cssClass" value="alert-warning"/>
                                        </c:when>
                                        <c:when test="${appointment.appointmentDate > date && appointment.isApproved}">
                                            <c:set var="cssClass" value="alert-success"/>
                                        </c:when>
                                        <c:when test="${appointment.appointmentDate < date && appointment.isApproved}">
                                            <c:set var="cssClass" value="alert-info"/>
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="cssClass" value="alert-danger"/>
                                        </c:otherwise>
                                    </c:choose>
                                    <div id="${showAppointmentClass}">
                                        <div class="col-sm-6" style="width: 100%">
                                            <div class="medical-card ${cssClass}">
                                                <div class="media">
                                                    <div class="media-left">
                                                        <img class="media-object img-circle profile-img" src="<c:url value="/resources/img/User_Default.png"/>">
                                                    </div>
                                                    <div class="media-body">
                                                        <h2 class="media-heading"><c:out value="${appointment.doctors.firstname} ${appointment.doctors.lastname}"/></h2>
                                                        <div class="specialization"><c:out value="${appointment.doctors.specialization.name}"/></div>
                                                        <div class="diagnosis"><c:out value="${appointment.description}"/></div>
                                                        <div class="diagnosis"><c:out value="${aDate}"/></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                                <div id="appointmentsHistoryListIsEmpty">
                                    <div class="well mcard_content">
                                        <div class="col-sm-6" style="width: 100%">
                                            <div class="medical-card ${cssClass}">
                                                <div class="media">
                                                    <div class="media-body">
                                                        <h3 class="media-heading" style="text-align: center"><spring:message code="messages.noPastAppointments"/></h3>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="pendingAppointmentsListIsEmpty">
                                    <div class="well mcard_content">
                                        <div class="col-sm-6" style="width: 100%">
                                            <div class="medical-card ${cssClass}">
                                                <div class="media">
                                                    <div class="media-body">
                                                        <h3 class="media-heading" style="text-align: center"><spring:message code="messages.noPendingAppointments"/></h3>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            <script>
                                var listPastAppointmentsLength = "${listPastAppointmentsLength}";
                                var listPendingAppointmentsLength = "${listPendingAppointmentsLength}";

                                var showAppointmentHistory = function () {
                                    $("#appointmentsHistory").show();
                                    $("#pendingAppointments").hide();
                                    $("#appointmentsHistoryLink").addClass("active");
                                    $("#pendingAppointmentsLink").removeClass("active");
                                    if (listPastAppointmentsLength == 0) {
                                        $("#appointmentsHistoryListIsEmpty").show();
                                        $("#pendingAppointmentsListIsEmpty").hide();
                                        $("#shown_if_not_empty").hide();
                                    } else {
                                        $("#appointmentsHistoryListIsEmpty").hide();
                                        $("#pendingAppointmentsListIsEmpty").hide();
                                        $("#shown_if_not_empty").show();
                                    }
                                };

                                var showPendingAppointments = function () {
                                    $("#appointmentsHistory").hide();
                                    $("#pendingAppointments").show();
                                    $("#pendingAppointmentsLink").addClass("active");
                                    $("#appointmentsHistoryLink").removeClass("active");
                                    if (listPendingAppointmentsLength == 0) {
                                        $("#pendingAppointmentsListIsEmpty").show();
                                        $("#appointmentsHistoryListIsEmpty").hide();
                                        $("#shown_if_not_empty").hide();
                                    } else {
                                        $("#appointmentsHistoryListIsEmpty").hide();
                                        $("#pendingAppointmentsListIsEmpty").hide();
                                        $("#shown_if_not_empty").show();
                                    }
                                };

                                $("#appointmentsHistoryLink").click(showAppointmentHistory);
                                $("#pendingAppointmentsLink").click(showPendingAppointments);
                            </script>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
