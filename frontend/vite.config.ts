// frontend/vite.config.ts

import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  build: {
    outDir: 'dist', // Ensure the build output directory is 'dist'
    emptyOutDir: true, // Clean the output directory before each build
    sourcemap: false, // Disable source maps in production for security and performance
  },
  server: {
    // Optional: Adjust the development server settings if needed
    port: 3000,
    open: true, // Automatically open the app in the browser on server start
  },
})
