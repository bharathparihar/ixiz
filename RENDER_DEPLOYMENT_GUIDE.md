# Render.com Free Deployment Guide for VCardPro

We have successfully prepared your VCardPro app for Render.com by adding a `Dockerfile` and a `start.sh` script. These files tell Render exactly how to build and run your Laravel app in its Free Docker environment.

Follow these exact steps to get your app live on Render for free.

## Step 1: Create a Free PostgreSQL Database

Render provides a free PostgreSQL database which we’ll use for your application. Since SQLite isn't great for Render's ephemeral (temporary) file system, PostgreSQL is the perfect free choice.

1. Log in to [Render.com Dashboard](https://dashboard.render.com/).
2. Click the **New +** button in the top right corner and select **PostgreSQL**.
3. Fill in the required details:
   - **Name**: `vcardpro_db` (or anything you like)
   - **Database**: `vcardpro_db`
   - **User**: `vcard_user`
4. Scroll down to the **Instance Type** section and make sure you select the **Free** tier ($0/month).
5. Click the **Create Database** button at the bottom.
6. Once the database is created, look for the **Internal Database URL** on the database's page (it will look something like `postgres://vcard_user...`). **Copy this URL** and save it somewhere accessible. You will need it in Step 3.

## Step 2: Create the Web Service

Now we’ll deploy the actual website code.

1. Click the **New +** button in the top right again and select **Web Service**.
2. Make sure you select **"Build and deploy from a Git repository"** and connect your public repository: `https://github.com/bharathparihar/ixiz`.
3. Fill in the service details:
   - **Name**: `vcardpro-app` (this will become your URL like `vcardpro-app.onrender.com`)
   - **Region**: (Choose the one geographically closest to you)
   - **Branch**: `main`
   - **Environment**: Select **Docker** (This is VERY important because Render's native PHP environment natively is not free, but Docker is).
4. Scroll down to the **Instance Type** and select the **Free** tier.

## Step 3: Add Environment Variables

This is the most crucial step. Before clicking create, you must tell the application how to connect to the database and set its basic configuration. 

1. Scroll down on the Create page and click **Advanced**.
2. Click **Add Environment Variable** to add each of the following keys and values exactly as shown:

- `APP_ENV` = `production`
- `APP_KEY` = *(Copy this from your local `.env` file! Open `.env` and copy the long string after `APP_KEY=`)*
- `APP_URL` = `https://vcardpro-app.onrender.com` *(Replace this with whatever name Render gave your web service)*
- `DB_CONNECTION` = `pgsql`
- `DB_URL` = *(Paste the **Internal Database URL** you copied in Step 1)*
- `FORCE_HTTPS` = `true`

## Step 4: Deploy!

1. Scroll to the very bottom and click **Create Web Service**.
2. Render will now start building your Docker image. This will automatically:
   - Install PHP 8.1 and Apache
   - Install all Composer dependencies
   - Install Node.js and run `npm run prod` to compile CSS/JS
3. The custom `start.sh` file I made for you will automatically run `php artisan migrate --force` whenever the server boots up, meaning your database will be perfectly populated the moment the deployment finishes!

---

## 💡 Quick Git Guide

Whenever you make new changes to your files on your computer and want Render to automatically update your website, just run these 3 commands in your terminal:

1. **Stage all changes:**
   ```powershell
   git add .
   ```
2. **Commit the changes with a message:**
   ```powershell
   git commit -m "Added a new feature"
   ```
3. **Push to GitHub:**
   ```powershell
   git push origin main
   ```
*(Render watches your GitHub `main` branch, so the moment you run `git push`, Render will automatically start rebuilding and updating your live website!)*
