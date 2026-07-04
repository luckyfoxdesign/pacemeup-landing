/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{astro,html,js,jsx,ts,tsx,md,mdx,vue,svelte}'],
  theme: {
    extend: {
      colors: {
        base: '#F4F1E9',
        paper: '#F4F1E9',
        surface: '#FFFFFF',
        text: '#0B0D0C',
        muted: '#5F6562',
        volt: '#C7FF2E',
        strain: '#FF4124',
        sync: '#1E5BFF',
        border: '#E4DFD3',
      },
      fontFamily: {
        hero: ['Anton', 'Archivo', 'system-ui', 'sans-serif'],
        display: ['Archivo', 'system-ui', 'sans-serif'],
        sans: ['Inter', 'system-ui', 'sans-serif'],
        mono: ['"IBM Plex Mono"', 'ui-monospace', 'monospace'],
      },
    },
  },
  plugins: [],
};
