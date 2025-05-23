class StatusFile {
  static String statusForSale(String language, int status, String data) {
    if (language.toLowerCase() == 'en') {
      return data;
    } else {
      switch (status) {
        case 0:
          return "Venta Pendiente de \nAprobación";
        case 1:
          return "Venta Aprobada/Entregada";
        case 2:
          return "Venta Rechazada";
        case 3:
          return "Propuesta de Venta Pendiente \nde Aprobación";
        case 4:
          return "Propuesta de Venta \nAprobada";
        case 5:
          return "Propuesta de Venta \nRechazada";
        case 6:
          return "Venta Aprobada";
        case 7:
          return "Pendiente Confirmación \nde Entrega";
        case 8:
          return "Cancelada";
      }
      return "";
      // } else {
      //   throw "";
    }
  }

  static String statusForOrder(String language, int status, String data) {
    if (language == 'en') {
      return data;
    } else if (language == 'es') {
      switch (status) {
        case 0:
          return "Enviada";
        case 1:
          return "Revisada";
        case 2:
          return "Procesada";
        case 3:
          return "Revisión de Línea de Crédito";
        case 4:
          return "Borrador";
        case 5:
          return "Cancelada";
      }
      return "";
    } else {
      return "";
    }
  }

  static String statusForWholesaler(String language, String data) {
    if (language.toLowerCase() == 'en') {
      return data;
    } else {
      switch (data.toLowerCase()) {
        case "active":
          return "Activa";
        case "inactive":
          return "Inactiva";
      }
      return "";
    }
  }

  static String statusForCustomer(String language, String data) {
    if (language.toLowerCase() == 'en') {
      return data;
    } else {
      switch (data.toLowerCase()) {
        case "active":
          return "Activa";
        case "inactive":
          return "Inactiva";
      }
      return "";
    }
  }

  static String visitFrequent(String language, int data) {
    if (language.toLowerCase() == 'en') {
      switch (data) {
        case 1:
          return "Twice a week";
        case 2:
          return "Weekly";
        case 3:
          return "Every two weeks";
        case 4:
          return "Every Three Weeks";
        case 5:
          return "Monthly";
      }
      return "";
    } else {
      switch (data) {
        case 1:
          return "Dos veces por semana";
        case 2:
          return "Semanalmente";
        case 3:
          return "Cada dos semanas";
        case 4:
          return "Cada 3 semanas";
        case 5:
          return "Mensualmente";
      }
      return "";
    }
  }

  static String statusForCreditline(String language, int status, String data) {
    if (language.toLowerCase() == 'en') {
      return data;
    } else {
      switch (status) {
        case 0:
          return "Pendiente Revisión \nde Mayorista";
        case 1:
          return "Pendiente de Enviar \na Institución";
        case 2:
          return "En cola de la Institución";
        case 3:
          return "Asociación Pendiente/\nEn cola de la Institución";
        case 4:
          return "En Evaluación/\nAsociación Pendiente";
        case 5:
          return "En Evaluación";
        case 6:
          return "Rechazada";
        case 7:
          return "Esperando Respuesta/\nAsociación Pendiente";
        case 8:
          return "Esperando Respuesta";
        case 12:
          return "Aprobada";
        case 13:
          return "Activa";
        case 14:
          return "Inactiva";
      }
      return "";
    }
  }

  static String bankAccountType(String language, int accountType) {
    if (language.toLowerCase() == 'en') {
      switch (accountType) {
        case 1:
          return "Saving";
        case 2:
          return "Current";
        // case 3:
        //   return "Checking";
      }
      return "";
    } else {
      switch (accountType) {
        case 1:
          return "Ahorro";
        case 2:
          return "Corriente";
        // case 3:
        //   return "Checking";
      }
      return "";
    }
  }

  static String monthDistributionPeriod(String language, int accountType) {
    if (language.toLowerCase() == 'en') {
      switch (accountType) {
        case 1:
          return "Today";
        case 2:
          return "Tomorrow";
        case 3:
          return "Current Week";
        case 4:
          return "Next Week";
        case 5:
          return "Next 2 Week";
        case 6:
          return "Next 3 Week";
      }
      return "";
    } else {
      switch (accountType) {
        case 1:
          return "Hoy";
        case 2:
          return "Mañana";
        case 3:
          return "Semana actual";
        case 4:
          return "Próxima semana";
        case 5:
          return "Próximas 2 semanas";
        case 6:
          return "Próximas 3 semanas";
      }
      return "";
    }
  }

  static String statusForFinState(String language, int j, String data) {
    if (language.toLowerCase() == 'en') {
      return data;
    } else {
      switch (j) {
        case 0:
          return "Vigente"; //"Al Corriente";
        case 1:
          return "Día de vencimiento"; //"Pendiente";
        case 2:
          return "Vencida"; //"Vencido";
        case 3:
          return "Pagado Parcialmente";
        case 4:
          return "Pagado";
      }
      return "";
    }
  }

  static String statusForSettlement(String language, int j, String data) {
    if (language.toLowerCase() == 'en') {
      return data;
    } else {
      switch (j) {
        case 0:
          return "Propuesta";
        case 1:
          return "Confirmada";
        case 2:
          return "Cancelada";
      }
      return "";
    }
  }
}
