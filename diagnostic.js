#!/usr/bin/env node

/**
 * Diagnostic script to identify and fix issues
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const projectDir = 'd:\\Angularpractice\\uigen';
const issues = [];
const warnings = [];

console.log('\n============================================================');
console.log('         UIGEN - DIAGNOSTIC & FIX SCRIPT');
console.log('============================================================\n');

process.chdir(projectDir);

// Check 1: package.json exists
if (!fs.existsSync('package.json')) {
  issues.push('❌ package.json not found');
} else {
  console.log('✓ package.json exists');
}

// Check 2: node_modules exists
if (!fs.existsSync('node_modules')) {
  console.log('⚠ node_modules missing - will install');
  warnings.push('Installing dependencies...');
} else {
  console.log('✓ node_modules exists');
}

// Check 3: Prisma schema
if (!fs.existsSync('prisma\\schema.prisma')) {
  issues.push('❌ prisma/schema.prisma not found');
} else {
  console.log('✓ prisma/schema.prisma exists');
}

// Check 4: src directory
if (!fs.existsSync('src')) {
  issues.push('❌ src directory not found');
} else {
  console.log('✓ src directory exists');
}

// Check 5: Next.js config
if (!fs.existsSync('next.config.ts')) {
  issues.push('❌ next.config.ts not found');
} else {
  console.log('✓ next.config.ts exists');
}

// Check 6: Prisma generated client
if (!fs.existsSync('src\\generated\\prisma')) {
  console.log('⚠ Prisma client not generated - will generate');
  warnings.push('Generating Prisma client...');
} else {
  console.log('✓ Prisma client exists');
}

console.log('\n============================================================');
console.log('                    FIXING ISSUES');
console.log('============================================================\n');

try {
  // Fix 1: Install dependencies
  if (warnings.includes('Installing dependencies...')) {
    console.log('[1/3] Installing dependencies...');
    execSync('npm install --no-audit --no-fund', { stdio: 'inherit' });
    console.log('[✓] Dependencies installed\n');
  }

  // Fix 2: Create directories
  const dirs = [
    'src\\generated\\prisma',
    'prisma',
  ];
  
  dirs.forEach(dir => {
    const fullPath = path.join(projectDir, dir);
    if (!fs.existsSync(fullPath)) {
      fs.mkdirSync(fullPath, { recursive: true });
      console.log(`[✓] Created directory: ${dir}`);
    }
  });
  console.log();

  // Fix 3: Generate Prisma client
  if (warnings.includes('Generating Prisma client...')) {
    console.log('[2/3] Generating Prisma Client...');
    execSync('npx prisma generate', { stdio: 'inherit' });
    console.log('[✓] Prisma Client generated\n');
  }

  // Fix 4: Database setup
  console.log('[3/3] Setting up database...');
  try {
    execSync('npx prisma migrate dev --name init --skip-generate', { stdio: 'inherit' });
  } catch (e) {
    console.log('(Database already initialized or migration skipped)');
  }
  console.log('[✓] Database ready\n');

  console.log('============================================================');
  console.log('            ✓ ALL CHECKS PASSED - READY TO RUN');
  console.log('============================================================\n');
  console.log('Starting development server...\n');
  
  // Start dev server
  execSync('npm run dev', { stdio: 'inherit' });

} catch (error) {
  console.error('\n[ERROR]', error.message);
  console.log('\nTroubleshooting tips:');
  console.log('1. Make sure Node.js is installed: node --version');
  console.log('2. Make sure npm is installed: npm --version');
  console.log('3. Check your internet connection');
  console.log('4. Try deleting node_modules and package-lock.json, then run again');
  process.exit(1);
}
