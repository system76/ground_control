module.exports = {
  purge: [
    '../lib/ground_control_web/**/*.ex',
    '../lib/ground_control_web/**/*.leex',
    '../lib/ground_control_web/**/*.eex',
    './js/**/*.js'
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
