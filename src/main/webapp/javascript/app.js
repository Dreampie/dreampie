// Place third party dependencies in the lib folder
//
// Configure loading modules from the lib directory,
// except 'app' ones, 
requirejs.config({
    "baseUrl": "/",
    "paths": {
        "app": "javascript/app",
        "lib": "javascript/lib",
        "jquery": "webjars/jquery/1.11.1/jquery.min",
        "html5shiv": "webjars/html5shiv/3.7.2/html5shiv.min",
        "respond": "webjars/respond/1.4.2/src/respond.min",
        "jquery.query": "javascript/lib/jquery/jquery.query",
        "bootstrap": "webjars/bootstrap/3.2.0/js/bootstrap.min",
        "bootstrap-datepicker": "webjars/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker",
        "jquery-cookie": "webjars/jquery-cookie/1.4.0/jquery.cookie",
        "jquery.scrollUp": "javascript/lib/jquery/jquery.scrollUp.min",
        "jquery.unveil": "javascript/lib/jquery/jquery.unveil.min",
        "jquery.ba-resize": "javascript/lib/jquery/jquery.ba-resize.min",
        "bootstrap-messager": "javascript/lib/bootstrap/js/messenger.min",
        "bootstrap-maxlength": "javascript/lib/bootstrap/js/bootstrap-maxlength",
        "bootstrap-tour": "javascript/lib/bootstrap/js/bootstrap-tour.min",
        "bootstrapx-clickover": "javascript/lib/bootstrap/js/bootstrap-clickover.min",
        "ie8-responsive-file-warning": "javascript/lib/ie8-responsive-file-warning",
        "mmenu": ["javascript/lib/mmenu/js/jquery.mmenu.min", "javascript/lib/mmenu/js/jquery.hammer.min"],
        "summernote": ["javascript/lib/summernote/js/summernote.min", "javascript/lib/summernote/lang/summernote-zh-CN"],
        "json3": "webjars/json3/3.3.2/json3.min",
        "_layout": "javascript/app/main/_layout",
        "backbone": "webjars/backbonejs/1.1.2/backbone-min",
        "underscore": "webjars/underscorejs/1.6.0/underscore-min"
    },
    "shim": {
        'backbone': {
            //These script dependencies should be loaded before loading
            //backbone.js
            deps: ['underscore', 'jquery'],
            //Once loaded, use the global 'Backbone' as the
            //module value.
            exports: 'Backbone'
        },
        'underscore': {
            exports: '_'
        },
        "bootstrap": {
            "deps": ["jquery"]
        },
        "bootstrap-datepicker": {
            "deps": ["bootstrap"]
        },
        "bootstrap-messager": {
            "deps": ["bootstrap"]
        },
        "bootstrap-maxlength": {
            "deps": ["bootstrap"]
        },
        "bootstrap-tour": {
            "deps": ["bootstrap"]
        },
        "bootstrapx-clickover": {
            "deps": ["bootstrap"]
        },
        "json3": {
            "deps": ["jquery"]
        },
        "jquery-cookie": {
            "deps": ["jquery"]
        },
        "mmenu": {
            "deps": ["jquery"]
        },
        "summernote": {
            "deps": ["jquery"]
        },
        "respond": {
            "deps": ["jquery"]
        },
        "jquery.query": {
            "deps": ["jquery"]
        },
        "jquery-cookie": {
            "deps": ["jquery"]
        },
        "jquery.scrollUp": {
            "deps": ["jquery"]
        },
        "jquery.unveil": {
            "deps": ["jquery"]
        },
        "jquery.ba-resize": {
            "deps": ["jquery"]
        },
        "_layout": {
            "deps": ["jquery", "jquery.query", "jquery.scrollUp", "jquery.unveil", "jquery.ba-resize", "mmenu", "bootstrap", "bootstrap-messager", "bootstrap-maxlength", "bootstrap-tour", "ie8-responsive-file-warning"]
        }
    }
});

requirejs.onError = function (err) {
    console.log(err.requireType);
    if (err.requireType === 'timeout') {
        console.log('modules: ' + err.requireModules);
    }
    throw err;
};
// Load the main app module to start the app
//requirejs(["app/main/_layout"]);
requirejs(["_layout"]);
