exports.Competency = function Competency(name, description) {
    this.name = name;
    this.description = description;
    this.setName = function(nameData) {
        name = nameData;
    }
    this.getName = function() {
        return name;
    }

    this.setDescription = function(descriptionData) {
        description = descriptionData;
    }
    this.getDescription = function() {
        return description;
    }
};