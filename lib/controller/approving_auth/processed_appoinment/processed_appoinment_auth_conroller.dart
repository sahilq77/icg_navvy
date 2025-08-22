import 'package:get/get.dart';
import 'package:icg_navy/model/appoinment_history/appoinment_history_model.dart';
import 'package:icg_navy/model/medical_officer/pending_appoinments/pending_appoinments_medical_model.dart';

import '../../../model/approving_auth/pending_appoinment/pending_appoinments_auth_model.dart';
import '../../../model/approving_auth/processed_appoinment/processed_appoinment_auth_model.dart';

class ProcessedAppoinmentAuthConroller extends GetxController {
  var appointments = <ProcessedAppoinmentAuthModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDummyData();
  }

  void loadDummyData() {
    appointments.assignAll([
      ProcessedAppoinmentAuthModel(
        id: '1',
        name: 'Priya Kumar',
        relation: 'Wife',
        age: 32,
        gender: 'Female',
        status: 'Approved',
        type: 'OPD',
        hospital: 'City General Hospital',
        department: 'Medical Inspection OPD 02',
        date: '24/08/2025',
      ),
      ProcessedAppoinmentAuthModel(
        id: '2',
        name: 'Amit Sharma',
        relation: 'Self',
        age: 40,
        gender: 'Male',
        status: 'Processed',
        type: 'AME/PME',
        hospital: 'City General Hospital',
        department: 'Cardiology OPD 01',
        date: '25/08/2025',
      ),
      ProcessedAppoinmentAuthModel(
        id: '3',
        name: 'Sneha Patel',
        relation: 'Daughter',
        age: 15,
        gender: 'Female',
        status: 'Pending',
        type: 'Follow-up',
        hospital: 'Sunrise Medical Center',
        department: 'Pediatrics OPD 03',
        date: '26/08/2025',
      ),
      ProcessedAppoinmentAuthModel(
        id: '4',
        name: 'Rohan Verma',
        relation: 'Son',
        age: 22,
        gender: 'Male',
        status: 'Approved',
        type: 'OPD',
        hospital: 'City General Hospital',
        department: 'Orthopedics OPD 04',
        date: '27/08/2025',
      ),
    ]);
  }

  // Method to filter appointments based on criteria
  void filterAppointments({
    String? patientName,
    String? appointmentType,
    String? relation,
    DateTime? fromDate,
    DateTime? toDate,
  }) {
    var filtered = appointments.where((appointment) {
      bool matches = true;

      if (patientName != null &&
          patientName.isNotEmpty &&
          patientName != 'Priya Kumar') {
        matches =
            matches &&
            appointment.name.toLowerCase().contains(patientName.toLowerCase());
      }

      if (appointmentType != null && appointmentType != 'Select Type') {
        matches = matches && appointment.type == appointmentType;
      }

      if (relation != null && relation != 'Select') {
        matches = matches && appointment.relation == relation;
      }

      if (fromDate != null && toDate != null) {
        try {
          final appointmentDate = DateTime.parse(
            '${appointment.date.split('/').reversed.join('-')} 00:00:00',
          );
          matches =
              matches &&
              (appointmentDate.isAfter(fromDate.subtract(Duration(days: 1))) &&
                  appointmentDate.isBefore(toDate.add(Duration(days: 1))));
        } catch (e) {
          matches = false;
        }
      }

      return matches;
    }).toList();

    appointments.assignAll(filtered);
  }

  // Method to reset filters
  void resetFilters() {
    loadDummyData();
  }
}
