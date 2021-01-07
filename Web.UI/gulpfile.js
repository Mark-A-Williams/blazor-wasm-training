/// <binding ProjectOpened='default, watch' />
"use strict";

const
    gulp = require("gulp"),
    autoprefixer = require("gulp-autoprefixer"),
    changed = require("gulp-changed"),
    rename = require("gulp-rename"),
    sass = require("gulp-sass");

const scssPaths = ["*/**/*.scss", "Areas/**/*.scss"];

exports.default = gulp.parallel(sassCompile);
exports.watch = gulp.parallel(sassWatch);

function sassCompile(done) {
    var ext = ".css";
    var dest = function (file) {
        return file.base;
    };

    return gulp.src(scssPaths)
        .pipe(changed(dest, { extension: ext }))
        .pipe(sass({ outputStyle: "expanded" }).on("error", done))
        .pipe(autoprefixer({
            cascade: false
        }))
        .pipe(rename({
            extname: ext
        }))
        .pipe(gulp.dest(dest));
}

function sassWatch() {
    return gulp.watch(scssPaths, gulp.series(sassCompile));
}
