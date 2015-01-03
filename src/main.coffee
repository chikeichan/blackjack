window.app = new App()
window.appView = new AppView({model: app})

appView.$el.appendTo 'body'
