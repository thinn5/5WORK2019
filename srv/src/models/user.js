exports.User = function User(username, password, firstName, lastName, email, role) {
    this.username = username;
    this.password = password;
    this.firstName = firstName;
    this.lastName = lastName;
    this.email = email;
    this.role = role;

    this.setUsername = function(usernameData) {
        username = usernameData;
    }
    this.getUsername = function() {
        return username;
    }

    this.setPassword = function(passwordData) {
        password = passwordData;
    }
    this.getPassword = function() {
        return password;
    }

    this.setFirstName = function(firstNameData) {
        firstName = firstNameData;
    }
    this.getFirstName = function() {
        return firstName;
    }

    this.setLastName = function(lastNameData) {
        lastName = lastNameData;
    }
    this.getFirstName = function() {
        return lastName;
    }

    this.setEmail = function(emailData) {
        email = emailData;
    }
    this.getEmail = function() {
        return email;
    }

    this.setRole = function(roleData) {
        role = roleData;
    }
    this.getRole = function() {
        return role;
    }

};