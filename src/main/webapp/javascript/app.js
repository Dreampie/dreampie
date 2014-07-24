// Place third party dependencies in the lib folder
//
// Configure loading modules from the lib directory,
// except 'app' ones, 
requirejs.config({
    'baseUrl': '/',
    'paths': {
        'lib': 'javascript/lib',
        'app': 'javascript/app',
        'jquery': 'webjars/jquery/1.11.1/jquery.min',
        'html5shiv': 'webjars/html5shiv/3.7.2/html5shiv.min',
        'respond': 'webjars/respond/1.4.2/src/respond.min',
        'jquery-query': 'javascript/lib/jquery/jquery.query',
        'bootstrap': 'webjars/bootstrap/3.2.0/js/bootstrap.min',
        'bootstrap-datepicker': 'webjars/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker',
        'jquery-cookie': 'webjars/jquery-cookie/1.4.0/jquery.cookie',
        'jquery-form': 'webjars/jquery-form/3.28.0-2013.02.06/jquery.form',
        'jquery-scrollUp': 'javascript/lib/jquery/jquery.scrollUp.min',
        'jquery-unveil': 'javascript/lib/jquery/jquery.unveil.min',
        'jquery-ba-resize': 'javascript/lib/jquery/jquery.ba-resize.min',
        'bootstrap-messenger': 'javascript/lib/bootstrap/js/messenger.min',
        'bootstrap-maxlength': 'javascript/lib/bootstrap/js/bootstrap-maxlength',
        'bootstrap-tour': 'javascript/lib/bootstrap/js/bootstrap-tour.min',
        'bootstrapx-clickover': 'javascript/lib/bootstrap/js/bootstrap-clickover.min',
        'ie8-responsive-file-warning': 'javascript/lib/ie8-responsive-file-warning',
        'jquery-mmenu': 'javascript/lib/mmenu/js/jquery.mmenu.min.all',
        'jquery-hammer': 'javascript/lib/mmenu/js/jquery.hammer.min',
        'summernote': 'javascript/lib/summernote/js/summernote.min',
        'summernote-zh-CN': 'javascript/lib/summernote/lang/summernote-zh-CN',
        'codemirror': 'webjars/codemirror/4.4/lib/codemirror',
        'json3': 'webjars/json3/3.3.2/json3.min',
        'angularjs':'webjars/angularjs/1.3.0-beta.15/angular.min',
        'backbone': 'webjars/backbonejs/1.1.2/backbone-min',
        'underscore': 'webjars/underscorejs/1.6.0/underscore-min',
        'backbone-localstorage': 'webjars/backbone-localstorage/1.1.0/backbone.localstorage-min',
        'requirejs-text': 'webjars/requirejs-text/2.0.10/text',
        'jquery-atmosphere': 'jquery/jquery.atmosphere-min',
        '_pagination': 'javascript/lib/_pagination',
        '_treenav': 'javascript/lib/_treenav',
        '_valid': 'javascript/lib/_valid',
        '_areaTag': 'javascript/lib/_areaTag',
        '_layout': 'javascript/app/_layout',
        '_main': 'javascript/app/_main',
        'user_models': 'javascript/app/user/models',
        'user_views': 'javascript/app/user/views',
        'blog_models': 'javascript/app/blog/models',
        'blog_views': 'javascript/app/blog/views'
    },
    'shim': {
        'backbone': {
            //These script dependencies should be loaded before loading
            //backbone.js
            deps: ['underscore', 'jquery'],
            //Once loaded, use the global 'Backbone' as the
            //module value.
            exports: 'Backbone'
        },
        'underscore': {exports: '_'},
        'bootstrap': ['jquery'],
        'bootstrap-datepicker': ['jquery','bootstrap'],
        'bootstrap-messenger': ['jquery','bootstrap'],
        'bootstrap-maxlength': ['jquery','bootstrap'],
        'bootstrap-tour': ['jquery','bootstrap'],
        'bootstrapx-clickover': ['jquery','bootstrap'],
        'json3': ['jquery'],
        'jquery-cookie': ['jquery'],
        'jquery-form': ['jquery'],
        'jquery-mmenu': ['jquery', 'jquery-hammer'],
        'summernote': ['jquery'],
        'summernote-zh-CN': ['jquery', 'summernote'],
        'respond': ['jquery'],
        'jquery-query': ['jquery'],
        'jquery-scrollUp': ['jquery'],
        'jquery-unveil': ['jquery'],
        'jquery-ba-resize': ['jquery'],
        'jquery-atmosphere': [ 'jquery' ],
        '_pagination': ['jquery'],
        '_treenav': ['jquery'],
        '_valid': ['jquery', 'jquery-form'],
        '_areaTag': ['jquery'],
        '_layout': ['jquery', 'jquery-query', 'jquery-scrollUp', 'jquery-unveil', 'jquery-ba-resize', 'jquery-mmenu',
            'bootstrap', 'bootstrap-messenger', 'bootstrap-maxlength', 'bootstrap-tour', 'ie8-responsive-file-warning'],
        '_main': ['jquery', 'backbone', 'underscore'],
        'blog_models': ['jquery', '_main'],
        'blog_views': ['jquery', '_main', 'blog_models']
    }
});

requirejs.onError = function (err) {
//    console.log(err.requireType);
    if (err.requireType === 'timeout') {
        console.log('modules: ' + err.requireModules);
    }
    throw err;
};
// Load the main app module to start the app
//requirejs(['app/main/_layout']);
//require(['_layout']);
