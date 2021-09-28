enum Payment { cash, bankAlfalah, easyPaisa }

final Map<Payment, Map<String, String>> payments = {
  Payment.cash: {
    'name': 'By Cash',
    'value': 'cash',
  },
  Payment.bankAlfalah: {
    'name': 'Bank Alfalah',
    'value': 'bank_alfalah',
  },
  Payment.easyPaisa: {
    'name': 'Easy Paisa',
    'value': 'easy_paisa',
  }
};
