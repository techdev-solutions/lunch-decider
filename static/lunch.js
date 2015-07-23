function LunchOptionModel(lunchOption) {
  var self = this;
  this.lunchOption = ko.observable(lunchOption);

  this.getLunchOption = function() {
    function randomOptionLoaded() {
      self.lunchOption(JSON.parse(this.responseText));
    }
    self.lunchOption({name: 'calculating...'});
    var request = new XMLHttpRequest();
    request.onload = randomOptionLoaded;
    request.open('get', '/random', true);
    request.send();
  }
}

function AvailableOptionsModel() {
  var self = this;
  this.options = ko.observableArray();

  this.addNewLunchOption = function(form) {
    function submitted() {
      self.options.push({id: this.responseText, name: form.name.value, count: 0});
    }
    var request = new XMLHttpRequest();
    request.onload = submitted;
    request.open('post', '/options', true);
    request.send('name=' + form.name.value);
  };

  this.removeOption = function(option) {
    function removed() {
      self.options.remove(option);  
    } 
    var request = new XMLHttpRequest();
    request.onload = removed;
    request.open('delete', '/options/' + option.id, true);
    request.send();
  }

  function loaded() {
    self.options(JSON.parse(this.responseText));
  }
  var request = new XMLHttpRequest();
  request.onload = loaded;
  request.open('get', '/options', true);
  request.send();
}

ko.applyBindings(new LunchOptionModel({name: '...'}), document.getElementById('lunch_decider'));
ko.applyBindings(new AvailableOptionsModel(), document.getElementById('lunch_options'));
