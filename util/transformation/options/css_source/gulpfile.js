var gulp = require('gulp'), watch = require('gulp-watch');
const sass = require('gulp-sass')(require('sass'));


const stylesSource = './styles/**/*.scss';
const stylesDest = '..';


gulp.task('watch', function () {
    watch(stylesSource, gulp.series('sass'));
});

// compile scss to css and create maps
gulp.task('sass', function () {
    return gulp.src('./styles/main.scss')
        .pipe(sass().on('error', sass.logError))
        .pipe(gulp.dest(stylesDest));
});


// compile scss to css, compress and rename to *.min
// gulp.task('cssmin', function () {
//     return gulp.src('./app/assets/styles/main.scss')
//         .pipe(sass({ outputStyle: 'compressed' }).on('error', sass.logError))
//         .pipe(rename(function (path) {
//             return {
//                 dirname: path.dirname + "",
//                 basename: path.basename + ".min",
//                 extname: ".css"
//             };
//         }))
//         .pipe(gulp.dest(stylesDest));
// });
