// Abstract class
abstract class BankAccount {
  // Private properties (encapsulated)
  String _accountHolderName;
  double _balance;

  // Constructor
  BankAccount(this._accountHolderName, this._balance);

  // Getter for account holder name
  String get accountHolderName => _accountHolderName;

  // Getter for balance
  double get balance => _balance;

  // Abstract method for depositing money (to be implemented by subclasses)
  void deposit(double amount);

  // Abstract method for withdrawing money (to be implemented by subclasses)
  void withdraw(double amount);
}

// Base class (Superclass) to demonstrate Encapsulation and Abstraction
class Account extends BankAccount {
  // Constructor
  Account(String accountHolderName, double balance)
      : super(accountHolderName, balance);

  // Method to deposit money (Implemented from abstract class)
  @override
  void deposit(double amount) {
    if (amount > 0) {
      _balance += amount;
      print('Deposited \$${amount.toStringAsFixed(2)}. New balance: \$${_balance.toStringAsFixed(2)}');
    } else {
      print('Invalid deposit amount.');
    }
  }

  // Method to withdraw money (Implemented from abstract class)
  @override
  void withdraw(double amount) {
    if (amount > 0 && amount <= _balance) {
      _balance -= amount;
      print('Withdrew \$${amount.toStringAsFixed(2)}. Remaining balance: \$${_balance.toStringAsFixed(2)}');
    } else {
      print('Invalid withdrawal amount or insufficient funds.');
    }
  }
}

// Subclass (Derived Class) to demonstrate Inheritance and Abstraction
class SavingsAccount extends Account {
  double interestRate;

  // Constructor
  SavingsAccount(String accountHolderName, double balance, this.interestRate)
      : super(accountHolderName, balance);

  // Method to add interest
  void addInterest() {
    double interest = (balance * interestRate) / 100;
    deposit(interest);
    print('Interest of \$${interest.toStringAsFixed(2)} added.');
  }
}

// Subclass to demonstrate Polymorphism and Abstraction
class CurrentAccount extends Account {
  double overdraftLimit;

  // Constructor
  CurrentAccount(String accountHolderName, double balance, this.overdraftLimit)
      : super(accountHolderName, balance);

  // Override withdraw method to account for overdraft (Polymorphism)
  @override
  void withdraw(double amount) {
    if (amount > 0 && amount <= (balance + overdraftLimit)) {
      _balance -= amount;
      print('Withdrew \$${amount.toStringAsFixed(2)} (Overdraft used if applicable). Remaining balance: \$${_balance.toStringAsFixed(2)}');
    } else {
      print('Invalid withdrawal amount or exceeds overdraft limit.');
    }
  }
}

void main() {
  // Encapsulation Example
  print('=== Encapsulation Example ===');
  Account account = Account('John Doe', 1000.0);
  print('Account Holder: ${account.accountHolderName}');
  account.deposit(500.0);
  account.withdraw(300.0);

  // Inheritance Example
  print('\n=== Inheritance Example ===');
  SavingsAccount savingsAccount = SavingsAccount('Jane Doe', 2000.0, 5.0);
  print('Account Holder: ${savingsAccount.accountHolderName}');
  savingsAccount.addInterest();

  // Polymorphism Example
  print('\n=== Polymorphism Example ===');
  CurrentAccount currentAccount = CurrentAccount('Jack Smith', 500.0, 200.0);
  print('Account Holder: ${currentAccount.accountHolderName}');
  currentAccount.withdraw(600.0);
  currentAccount.withdraw(800.0); // Exceeds overdraft limit
}
