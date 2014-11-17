gulp = require 'gulp'

GulpEste = require 'gulp-este'
config = require './app/server/config'
runSequence = require 'run-sequence'
yargs = require 'yargs'
# taskFixtures = require './tasks/fixtures.coffee'

args = yargs
  .alias 'p', 'production'
  .argv

este = new GulpEste __dirname, args.production, '../../../..'

paths =
  stylus: [
    'app/client/css/app.styl'
  ]
  coffee: [
    'bower_components/este-library/este/**/*.coffee'
    'app/**/*.coffee'
  ]
  jsx: [
    'app/**/*.jsx'
  ]
  js: [
    'bower_components/closure-library/**/*.js'
    'bower_components/este-library/este/**/*.js'
    'app/**/*.js'
    'tmp/**/*.js'
    '!**/build/**'
    '!**/*_test.js'
  ]
  unittest: [
    'app/**/*_test.js'
    # Useful for in app library development together with 'bower link'.
    'bower_components/este-library/este/**/*_test.js'
  ]
  compiler: 'bower_components/closure-compiler/compiler.jar'
  externs: [
    'app/client/js/externs.js'
    'bower_components/react-externs/externs.js'
  ]
  thirdParty:
    development: [
      'thirdparty/polymergestures.min.js'
      'bower_components/react/react.js'
    ]
    production: [
      'thirdparty/polymergestures.min.js'
      'bower_components/react/react.min.js'
    ]

dirs =
  googBaseJs: 'bower_components/closure-library/closure/goog'
  watch: ['app', 'bower_components/este-library/este']

gulp.task 'stylus', ->
  este.stylus paths.stylus

gulp.task 'coffee', ->
  este.coffee paths.coffee

gulp.task 'jsx', ->
  este.jsx paths.jsx

gulp.task 'transpile', (done) ->
  runSequence 'stylus', 'coffee', 'jsx', done

gulp.task 'deps', ->
  este.deps paths.js

gulp.task 'unittest', ->
  este.unitTest dirs.googBaseJs, paths.unittest

gulp.task 'dicontainer', ->
  este.diContainer dirs.googBaseJs, [
    name: 'app.DiContainer'
    resolve: ['App']
  ,
    name: 'server.DiContainer'
    resolve: ['server.App']
  ]

gulp.task 'concat-deps', ->
  este.concatDeps()

gulp.task 'compile-clientapp', ->
  este.compile paths.js, 'app/client/build',
    compilerPath: paths.compiler
    compilerFlags:
      closure_entry_point: 'app.main'
      define: [
        'goog.array.ASSUME_NATIVE_FUNCTIONS=true'
        'goog.dom.ASSUME_STANDARDS_MODE=true'
        'goog.dom.classlist.ALWAYS_USE_DOM_TOKEN_LIST=true'
        'goog.json.USE_NATIVE_JSON=true'
        'goog.net.XmlHttpDefines.ASSUME_NATIVE_XHR=true'
        'goog.style.GET_BOUNDING_CLIENT_RECT_ALWAYS_EXISTS=true'
      ]
      externs: paths.externs

gulp.task 'compile-serverapp', ->
  este.compile paths.js, 'app/server/build',
    compilerPath: paths.compiler
    compilerFlags:
      closure_entry_point: 'server.main'
      # NOTE(steida): To have compiled code readable, so we can trace errors.
      debug: true
      externs: paths.externs.concat este.getNodeJsExterns()
      formatting: 'PRETTY_PRINT'

gulp.task 'concat-all', ->
  este.concatAll
    'app/client/build/app.js': paths.thirdParty

gulp.task 'livereload-notify', ->
  este.liveReloadNotify()

gulp.task 'js', (done) ->
  runSequence [
    'deps' if este.shouldCreateDeps()
    'unittest'
    'dicontainer'
    'concat-deps'
    'compile-clientapp' if args.production
    'compile-serverapp' if args.production
    'concat-all'
    'livereload-notify' if este.shouldNotify()
    done
  ].filter((task) -> task)...

gulp.task 'build', (done) ->
  runSequence 'transpile', 'js', done

gulp.task 'env', ->
  este.setNodeEnv()

gulp.task 'livereload-server', ->
  este.liveReloadServer() #config.httpsOptions

gulp.task 'watch', ->
  este.watch dirs.watch,
    coffee: 'coffee'
    css: 'livereload-notify'
    js: 'js'
    jsx: 'jsx'
    styl: 'stylus'
  , (task) -> gulp.start task

gulp.task 'server', este.bg 'node', ['app/server']

gulp.task 'run', (done) ->
  runSequence [
    'env'
    'livereload-server' if !args.production
    'watch'
    'server'
    done
  ].filter((task) -> task)...

gulp.task 'default', (done) ->
  runSequence 'build', 'run', done

gulp.task 'bump', (done) ->
  este.bump './*.json', yargs, done


