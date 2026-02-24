# VCardPro — Complete Application Functionality

> **Last updated:** 2026-02-21  
> **Stack:** Laravel 10 | Multi-Tenant (Stancl/Tenancy) | PostgreSQL/MySQL | Spatie Media Library

---

## Table of Contents

1. [User Roles](#1-user-roles)
2. [Authentication & Security](#2-authentication--security)
3. [Public / Frontend](#3-public--frontend)
4. [Admin Panel (Tenant User)](#4-admin-panel-tenant-user)
5. [Super Admin Panel](#5-super-admin-panel)
6. [VCard System](#6-vcard-system)
7. [WhatsApp Store System](#7-whatsapp-store-system)
8. [Subscription & Billing](#8-subscription--billing)
9. [Payment Gateways](#9-payment-gateways)
10. [NFC Card System](#10-nfc-card-system)
11. [Affiliate / Referral System](#11-affiliate--referral-system)
12. [Communication & Notifications](#12-communication--notifications)
13. [Analytics & Reporting](#13-analytics--reporting)
14. [Settings & Configuration](#14-settings--configuration)
15. [API (Mobile App / External)](#15-api-mobile-app--external)
16. [Add-On / Plugin System](#16-add-on--plugin-system)
17. [Localization / Multi-Language](#17-localization--multi-language)
18. [Business Cards & Groups](#18-business-cards--groups)
19. [Scheduled Tasks & Jobs](#19-scheduled-tasks--jobs)
20. [Infrastructure & Utilities](#20-infrastructure--utilities)

---

## 1. User Roles

| Role | Description |
|------|-------------|
| **Super Admin** | Full platform control — manages users, plans, payments, templates, site content, settings |
| **Admin (Tenant)** | A registered user (tenant) — creates VCards, WhatsApp Stores, manages their subscription |
| **User** | Basic user role with a simplified dashboard (`UserDashboardController`) |

---

## 2. Authentication & Security

- **Registration** — Email-based user sign-up with email verification
- **Login** — Standard email/password authentication
- **Social Login** — Google, Facebook, and other OAuth providers (`SocialAuthController`)
- **Email Verification** — Mandatory or optional email verification flow
- **Password Reset** — "Forgot password" with email link flow
- **Two-Factor Authentication (2FA)** — TOTP-based 2FA (enable/disable/verify)
- **Impersonation** — Super Admin can log in as any tenant user
- **Account Deletion** — Users can request full account deletion
- **XSS Middleware** — Input sanitization across forms
- **Google reCAPTCHA** — v2 and v3 support on registration (configurable in settings)
- **Google Wallet Pass** — Generate Google Wallet passes for VCards (API-based, add-on module)

---

## 3. Public / Frontend

### 3.1 Landing Page
- **Home page** with dynamic sections (hero slider, features, testimonials, FAQs, pricing, about us, "What Drives Us")
- **VCard Templates showcase** — Browse available vcard designs
- **Pricing / Plans page** — View subscription plans with features
- **Blog** — Public blog with individual post pages (`/blog`, `/blog/{slug}`)
- **Custom Pages** — Admin-created CMS pages (`/custom/{slug}`)
- **FAQ Section** — Frequently asked questions
- **Cookie Consent** — Accept/decline cookie banner

### 3.2 Legal Pages
- Terms & Conditions
- Privacy Policy
- Refund & Cancellation Policy
- Shipping & Delivery Policy
- Imprint Policy

### 3.3 Contact & Subscription
- **Contact Us** — Public contact form (`ContactRequest`)
- **Email Subscription** — Newsletter signup from the landing page
- **Theme Configuration** — Multiple frontend theme options

---

## 4. Admin Panel (Tenant User)

### 4.1 Dashboard
- Overview statistics (VCards count, subscribers, enquiries, appointments)
- Dashboard charts (analytics over time)

### 4.2 VCard Management
- **Create / Edit / Delete VCards** — Full CRUD with template selection
- **Duplicate VCards** — Clone an existing VCard
- **VCard Status** — Activate/deactivate individual VCards
- **URL Alias** — Custom short-URL for each VCard (auto-generate or manual)
- **Password Protection** — Optional password lock on VCards
- **Custom Domain** — Map a custom domain to a VCard
- **AI Description** — Generate VCard descriptions via OpenAI integration

### 4.3 VCard Content Modules
Each VCard can contain:
- **Services** — List of service offerings (with slider view toggle)
- **Products** — Product catalog with images, pricing, categories
- **Testimonials** — Client testimonials/reviews
- **Blogs** — VCard-specific blog posts
- **Gallery** — Image gallery
- **Banners** — Hero/banner images
- **Custom Links** — External links (show as button, open in new tab options)
- **Instagram Embed** — Embedded Instagram posts
- **LinkedIn Embed** — Embedded LinkedIn posts
- **Iframes** — Custom embedded iframes
- **Social Links** — Social media profile links

### 4.4 Appointments
- **Schedule Appointments** — Visitors book time slots on VCards
- **Appointment Calendar** — Calendar view of all appointments
- **Appointment Status** — Mark as completed/pending
- **Paid Appointments** — Appointments with payment requirements
- **Available Days/Slots** — Configurable availability per VCard

### 4.5 Enquiries
- **Enquiry Form** — Visitors submit contact/enquiry forms on VCards
- **Enquiry List** — View and manage all submitted enquiries
- **Attachment Downloads** — Download files attached to enquiries

### 4.6 Subscribers & Contacts
- **VCard Subscribers** — Email subscribers per VCard
- **Contacts List** — View who saved the VCard as a contact
- **Export Contacts** — Download contacts as PDF or XLS

### 4.7 Product Orders
- **Product Transactions** — View and manage product orders
- **Order Status Updates** — Update order fulfillment status

### 4.8 User Settings
- **Profile Edit** — Update name, email, avatar
- **Password Change** — Update account password
- **Language Preference** — Choose display language
- **Dark/Light Mode** — Toggle theme mode
- **Payment Method Settings** — Configure per-user payment preferences
- **OpenAI Settings** — Configure AI API key for AI features
- **Custom Domain Management** — Apply, activate, and manage custom domains

### 4.9 Dynamic VCard Styling
- **Button Styles** — Customize CTA button appearance per VCard (`DynamicVcard`)
- **Section Ordering** — Rearrange VCard content sections

### 4.10 Virtual Backgrounds / E-Cards
- **Virtual Backgrounds** — Browse and create virtual background cards
- **Custom Virtual Backgrounds** — Upload custom backgrounds
- **QR Code Generator** — Generate and download QR codes for VCards
- **E-Card Download** — Download VCard as a shareable image

### 4.11 Subscription Management
- **View Current Plan** — See active subscription details
- **Upgrade Plan** — Browse and switch to higher plans
- **Choose Payment Type** — Select payment method for subscription
- **Subscription History** — View past subscription records

### 4.12 Affiliation
- **Referral Dashboard** — View affiliate stats and earnings
- **Send Invites** — Share referral links
- **Withdraw Earnings** — Request payout of affiliate commissions

### 4.13 NFC Cards (User Side)
- **My NFC Cards** — View ordered NFC cards
- **Order NFC Card** — Place new NFC card orders
- **NFC Card Details** — View NFC card specifications
- **Download NFC Card PDF** — Export NFC card design

### 4.14 Storage Management
- **Storage Dashboard** — View used vs. available storage
- **Storage Chart** — Visual breakdown by category (blogs, products, services, testimonials, social icons, galleries, profiles, PWA, avatars, WhatsApp store assets)

---

## 5. Super Admin Panel

### 5.1 Dashboard
- **Admin Dashboard** — Platform-wide statistics
- **Plan Chart** — Subscription distribution chart
- **Income Chart** — Revenue over time
- **Users List** — Quick-access user listing

### 5.2 User Management
- **Users CRUD** — Create, view, edit, delete tenant users
- **Admin Users CRUD** — Manage admin/staff accounts
- **User Status** — Activate/deactivate users
- **Email Verification Override** — Manually verify user emails
- **Change User Password** — Reset any user's password
- **Impersonate** — Log in as any user

### 5.3 Plan Management
- **Plans CRUD** — Create, edit, delete subscription plans
- **Plan Features** — Configure feature limits per plan:
  - Number of VCards
  - Number of WhatsApp Stores
  - Services, Products, Galleries, Testimonials, Blogs, Custom Links
  - Social Links, Iframes, Instagram/LinkedIn Embeds
  - Enquiry Forms, Password Protection, AI Text Generation
  - QR Code, SEO, Virtual Backgrounds
  - Appointments, NFC Cards, Business Hours, Banners
  - Storage Limit (MB)
  - Custom CSS/JS, Branding Removal
  - Bulk Export, E-Commerce
- **Plan Status** — Activate/deactivate plans
- **Default Plan** — Set a plan as the default for new users
- **Subscriber Plan Status** — Manage individual subscriber plan statuses
- **Plan Custom Fields** — Custom VCard number/price tiers per plan (`PlanCustomField`), allowing variable pricing based on VCard quantity

### 5.4 Subscription Management
- **All Subscriptions** — View all user subscriptions
- **Cash/Manual Plans** — Manage manually-paid subscriptions
- **Plan Status Approval** — Approve/reject manual payment subscriptions
- **Subscribed Plans Edit** — Modify user subscription details

### 5.5 VCard Management (Super Admin)
- **All VCards** — View all VCards across all tenants
- **VCard Analytics** — View analytics for any VCard
- **Duplicate VCard** — Clone VCards to any user
- **VCard Verification** — Mark VCards as verified/unverified
- **Templates Management** — View/manage available VCard templates (30+ templates)

### 5.6 WhatsApp Store Management (Super Admin)
- **All WhatsApp Stores** — View all stores across tenants
- **Store Analytics** — View analytics for any store
- **Duplicate Store** — Clone stores to any user

### 5.7 Content Management
- **Blogs CRUD** — Manage platform-level blog posts
- **Blog Status** — Publish/unpublish blogs
- **Blog Slugs** — Auto-generate or custom slugs
- **Custom Pages CRUD** — Create/manage custom CMS pages
- **Custom Page Status** — Publish/unpublish pages
- **FAQs Management** — CRUD for frontend FAQ section
- **Front Testimonials** — Manage landing page testimonials
- **Features Management** — Manage "Features" section on landing page
- **About Us** — Edit "About Us" section content
- **Front Slider** — Manage hero/banner slider
- **What Drives Us** — Manage "What Drives Us" section
- **Banner Management** — Site-wide banner configuration
- **App Download** — Manage app download links/section
- **Our Mission** — Manage "Our Mission" section

### 5.8 Location Management
- **Countries CRUD** — Manage country list
- **States CRUD** — Manage states/provinces
- **Cities CRUD** — Manage cities

### 5.9 Financial Management
- **Currencies** — Manage supported currencies
- **Coupon Codes CRUD** — Create/edit/delete coupon codes
- **Coupon Status** — Activate/deactivate coupons
- **Used Coupon Codes** — View coupon usage history
- **NFC Payment Status** — Manage NFC order payment statuses
- **NFC Order Status** — Update NFC order fulfillment

### 5.10 NFC Card Management (Super Admin)
- **NFC Card Types** — Create/edit/delete NFC card types
- **NFC Card Orders** — View all orders
- **NFC Card Tax** — Configure NFC purchase tax
- **Download Logo** — Download user-uploaded NFC logos
- **Download NFC PDF** — Export NFC card details

### 5.11 Affiliate Management
- **Affiliate Users** — View all affiliate registrations
- **Affiliation Transactions** — View all referral transactions
- **Withdraw Transactions** — View all withdrawal requests
- **Withdrawal Approval** — Approve/reject withdrawal requests

### 5.12 Email Management
- **Email Subscriptions** — View/manage newsletter subscribers
- **Send Mail** — Send bulk or individual emails (queued via `SendEmailJob`)
- **Email Templates** — Create/manage email templates
- **Mail Settings** — Configure SMTP/mail driver settings

### 5.13 Contact Requests
- **Contact Requests** — View/manage public contact form submissions
- **Export Contacts** — Export contact requests to Excel (`ContactRequestExport`)

### 5.14 Contact Inquiries (Landing Page)
- **Contact Us Submissions** — View/delete public landing page contact form submissions

### 5.15 Custom Domain Management (Super Admin)
- **Domain Requests** — View all custom domain applications
- **Domain Approval** — Approve/reject domain requests (`CustomDomainApprove`/`CustomDomainReject` mail)
- **Domain Notes** — Add admin notes to domain requests
- **Domain Status** — Manage domain activation status

---

## 6. VCard System

### 6.1 Templates
- **30+ VCard Templates** — Pre-designed responsive templates (vcard1 through vcard39)
- **Template Preview** — Preview templates before selection
- **Template Selection** — Choose/change template per VCard

### 6.2 VCard Features
- **Personal Info** — Name, occupation, company, job title, DOB, email, phone, alternative contacts
- **Profile & Cover Images** — Upload profile photo and cover/banner image (including video cover)
- **Social Media Links** — Links to all major social platforms
- **Location** — Address with map embed (Google Maps, iframe, or embed tag)
- **Business Hours** — Weekly schedule with customizable day formats
- **Services** — Showcase services with images, descriptions, pricing
- **Products** — E-commerce catalog with categories, images, multi-image support, pricing
- **Testimonials** — Client reviews and ratings
- **Blog Posts** — VCard-specific articles
- **Gallery** — Photo gallery with media uploads
- **Custom Links** — External links (button style, new tab options)
- **Iframes** — Embedded external content
- **Instagram/LinkedIn Embeds** — Social media post embeds
- **Banners** — Promotional banner images
- **Privacy Policy & Terms** — Per-VCard legal pages
- **QR Code** — Auto-generated QR code with downloadable sizes
- **Add to Contact (VCF)** — Download as VCF/vCard file
- **Password Protection** — Require password to view VCard
- **WhatsApp Share** — Share VCard via WhatsApp
- **Cookie Consent** — Per-VCard cookie notice
- **SEO** — Custom title, meta keywords, meta description, Google Analytics
- **Custom CSS/JS** — Advanced customization
- **Font Family & Size** — Typography customization
- **Branding** — Show/hide "Made by" branding
- **Multi-Language** — VCard content in multiple languages with language switcher
- **Enquiry Form** — Built-in contact/enquiry form
- **Appointment Booking** — Schedule appointments with configurable slots
- **Email Subscription** — Visitor newsletter signup
- **Hide Sticky Bar** — Toggle bottom sticky action bar
- **Services Slider View** — Toggle slider/grid layout for services
- **Service/Product Enquiry Buttons** — Enable/disable enquiry buttons

### 6.3 VCard Public URLs
- **Standard URL** — `/{alias}`
- **Legacy URL** — `/v/{alias}`
- **Custom Domain** — Map a personal domain to a VCard
- **Subdomain** — (optional) `{alias}.app-domain.com`

---

## 7. WhatsApp Store System

### 7.1 Store Management
- **Create / Edit / Delete Stores** — Full CRUD
- **Store Templates** — Pre-designed WhatsApp store templates
- **Template Customization** — Fonts, colors, SEO, advanced settings
- **Store Status** — Activate/deactivate stores
- **URL Alias** — Custom URL for each store
- **Duplicate Store** — Clone stores

### 7.2 Store Content
- **Products** — Product catalog with categories, images, pricing
- **Product Categories** — Organize products by category
- **Trending Videos** — Featured video content
- **Business Hours** — Weekly schedule
- **Store Policies** — Terms & Conditions, Privacy Policy, Refund & Cancellation, Shipping & Delivery

### 7.3 Store Features
- **WhatsApp Integration** — Direct WhatsApp chat for ordering
- **Product Orders** — Order management via WhatsApp
- **Order Status** — Track and update order fulfillment
- **Product Transactions** — Payment tracking for store products
- **Analytics** — Store visit and interaction analytics
- **Subscribers** — Email newsletter subscribers per store
- **SEO** — Store-level meta tags and Google Analytics
- **Custom CSS/JS** — Advanced customization
- **Font Customization** — Typography settings
- **Language Support** — Multi-language store content
- **Cover Image & Logo** — Store branding
- **Newsletter Popup** — Email capture popup
- **Sticky Bar** — Toggle bottom action bar
- **QR Code** — Downloadable QR code
- **Cookie Consent** — Store-level cookie notice
- **Slider Video Banner** — Video banner support

### 7.4 Public Store URLs
- `whatsapp-store/{alias}` — Store home
- `whatsapp-store/{alias}/products/{categoryId?}` — Product listing
- `whatsapp-store/{alias}/{id}/product-details` — Product detail page

---

## 8. Subscription & Billing

- **Multiple Plan Tiers** — Free, Basic, Premium (configurable)
- **Monthly / Yearly billing** — Configurable plan frequency
- **Trial Period** — Configurable trial days
- **Free Plan** — Zero-cost default plan option
- **Manual Payment** — Upload payment proof for admin approval
- **Coupon Codes** — Discount codes with expiration, usage limits
- **Plan Upgrade/Downgrade** — Switch between plans
- **Subscription Activation/Deactivation** — Automatic on payment
- **Subscription Notes** — Admin notes and payment attachments
- **Payment Attachments** — Upload and download payment proof files

---

## 9. Payment Gateways

| Gateway | Subscriptions | Products | Appointments | NFC Orders |
|---------|:------------:|:--------:|:------------:|:----------:|
| **Stripe** | ✅ | ✅ | — | ✅ |
| **PayPal** | ✅ | ✅ | — | ✅ |
| **Razorpay** | ✅ | ✅ | ✅ | ✅ |
| **Paystack** | ✅ | — | — | — |
| **Flutterwave** | ✅ | ✅ | ✅ | ✅ |
| **PhonePe** | ✅ | ✅ | ✅ | ✅ |
| **Payfast** | ✅ | ✅ | ✅ | ✅ |
| **Iyzico** | ✅ | ✅ | ✅ | ✅ |
| **Mercado Pago** | ✅ (module) | — | — | — |
| **Manual/Offline** | ✅ | — | — | — |

- **PayPal Payout** — Affiliate withdrawals via PayPal

---

## 10. NFC Card System

- **NFC Card Types** — Super Admin defines card types with images/specs
- **NFC Card Ordering** — Users order NFC cards linked to their VCards
- **NFC Tax Configuration** — Configurable tax on NFC purchases
- **NFC Order Management** — Track order and payment status
- **NFC Card PDF** — Generate downloadable NFC card PDF
- **Multi-Gateway Payment** — Pay for NFC cards via Stripe, PayPal, Razorpay, Flutterwave, PhonePe, Payfast, Iyzico
- **Logo Upload** — Upload custom logo for NFC card printing

---

## 11. Affiliate / Referral System

- **Affiliate Registration** — Users become affiliates via registration link
- **Affiliate Verification** — Email verification for affiliates
- **Referral Tracking** — Track sign-ups via affiliate links
- **Commission Earnings** — Earn commission on referred subscriptions
- **Withdrawal Requests** — Request payout of earnings
- **Withdrawal Approval** — Super Admin approves/rejects withdrawals
- **Withdrawal History** — View all transaction history
- **Invite System** — Send referral invitations via email

---

## 12. Communication & Notifications

### 12.1 Email Notifications (24 Mail Classes)
| Mail Class | Trigger |
|-----------|--------|
| `VerifyMail` | User email verification |
| `ForgetPasswordMail` | Password reset request |
| `ChangePasswordMail` | Password changed confirmation |
| `NewUserRegisteredMail` | New user signs up |
| `SubscriptionPaymentSuccessMail` | Subscription payment confirmed |
| `PlanExpirationReminder` | Plan about to expire (daily scheduled) |
| `ManualPaymentGuideMail` | Manual payment instructions |
| `SuperAdminManualPaymentMail` | Admin notified of manual payment |
| `AppointmentMail` | Appointment booked (to VCard owner) |
| `AppointmentApproveMail` | Appointment approved |
| `UserAppointmentMail` | Appointment confirmation (to visitor) |
| `ContactUsMail` | Landing page contact form |
| `LandingContactUsMail` | Alternative contact form |
| `SendinviteMail` | Affiliate invitation sent |
| `SendWithdrawalRequestChangedMail` | Affiliate withdrawal status changed |
| `CustomDomainApprove` | Custom domain request approved |
| `CustomDomainReject` | Custom domain request rejected |
| `ProductOrderSendCustomer` | Product order confirmation (to buyer) |
| `ProductOrderSendUser` | Product order notification (to seller) |
| `WhatsappStoreProductOrderSendUser` | WhatsApp store order notification |
| `AdminNfcOrderMail` | NFC order notification to admin |
| `NfcOrderStatusMail` | NFC order status update |
| `TwoFactorAuthenticationEnabledMail` | 2FA enabled confirmation |
| `SendEmail` | Custom email from Super Admin |

### 12.2 Queued Jobs
- `SendEmailJob` — Async email sending
- `SendWithdrawRequestMailJob` — Async withdrawal notification

### 12.3 Integrations
- **SMTP Configuration** — Configurable mail driver settings
- **Slack Integration** — Optional Slack notification module (add-on)

---

## 13. Analytics & Reporting

### 13.1 VCard Analytics
- **Visit Tracking** — Track VCard page views (with `analytics` middleware)
- **Analytics Dashboard** — Per-VCard analytics with charts
- **Chart Data** — Time-series visit data

### 13.2 WhatsApp Store Analytics
- **Store Visit Tracking** — Track store page views
- **Store Analytics Dashboard** — Per-store analytics with charts

### 13.3 Platform Analytics (Super Admin)
- **Income Charts** — Revenue visualization over time
- **Plan Distribution** — Subscription plan breakdown
- **User Growth** — User registration trends

---

## 14. Settings & Configuration

### 14.1 General Settings
- **Application Settings** — App name, logo, favicon, footer text
- **Theme Configuration** — Frontend theme selection and color customization
- **Google Analytics** — Platform-wide GA integration
- **Front CMS** — Landing page content management
- **Home Page Settings** — Customize home page sections

### 14.2 Payment Settings
- **Payment Method Configuration** — Enable/disable payment gateways
- **Gateway Credentials** — API keys for each payment provider
- **Manual Payment Guide** — Instructions for offline payments

### 14.3 Advanced Settings
- **Terms & Conditions** — Platform-level legal content
- **Mobile Validation** — Phone number validation rules
- **Social Settings** — Social login provider configuration
- **Sitemap Generation** — Auto-generate XML sitemap
- **Database Upgrade** — Run database migrations from admin panel

---

## 15. API (Mobile App / External)

### 15.1 Authentication API
- **Register** — User registration
- **Login/Logout** — Token-based authentication
- **Social Auth** — OAuth login via API

### 15.2 Admin (Tenant) API
- VCard CRUD, Services, Products, Galleries, Testimonials, Blogs
- Social Links, Banners, Iframes, Instagram/LinkedIn Embeds
- Enquiries, Appointments, Business Hours
- SEO, Privacy & Terms, Fonts, Manage Sections
- Subscription Plans, Dashboard Stats
- WhatsApp Store & Products, Categories, Orders, Business Hours, Trending Videos
- Payment gateway APIs (Stripe, PayPal, Razorpay, Paystack, Flutterwave, Payfast, Mercado Pago)
- Settings, Affiliation

### 15.3 Super Admin API
- User & Group Management
- Dashboard Statistics
- Profile Management
- Add-On Management
- Business Management
- Google Wallet Integration
- Slack Integration

### 15.4 Business Cards API
- Business Cards CRUD
- Groups Management

---

## 16. Add-On / Plugin System

- **Add-On Management** — Install/uninstall add-on modules
- **ZIP Upload** — Upload add-on as ZIP archive and extract
- **Module Detection** — `moduleExists()` helper for conditional feature loading
- **Known Modules:**
  - Mercado Pago (payment gateway)
  - Slack Integration (notifications)

---

## 17. Localization / Multi-Language

- **Language Management** — CRUD for languages
- **Default Language** — Set platform default language
- **Language Status** — Activate/deactivate languages
- **Translation Editor** — Edit translation strings per language
- **Per-User Language** — Users choose their preferred language
- **Per-VCard Language** — Each VCard can have its own default language
- **Language Switcher** — Public-facing language toggle on VCards and stores
- **RTL Support** — Right-to-left language support

---

## 18. Business Cards & Groups

- **Business Cards** — Create digital business cards linked to VCards (`BusinessCards` model)
- **Groups** — Organize business cards into groups (`Group` model)
- **API Management** — Full CRUD via API for both Admin and Super Admin
- **VCard Linking** — Each business card links to a VCard for data population

---

## 19. Scheduled Tasks & Jobs

| Command | Schedule | Description |
|---------|----------|-------------|
| `sitemap:generate` | Daily | Auto-generates XML sitemap |
| `PlanExpirationMailCommand` | Daily | Sends plan expiration reminder emails |

---

## 20. Infrastructure & Utilities

### 20.1 Multi-Tenancy
- **Stancl/Tenancy** — Full multi-tenant architecture
- **Tenant Isolation** — Each user's data is isolated via `tenant_id`
- **BelongsToTenant Trait** — Automatic tenant scoping on models

### 20.2 Storage & Media
- **Spatie Media Library** — File/image management
- **Storage Limits** — Per-plan storage quota enforcement (`StorageLimit` trait)
- **Storage Limit Exception** — Custom `StorageLimitExceededException` when quota exceeded
- **Storage Dashboard** — Visual storage usage tracking

### 20.3 Security
- **XSS Middleware** — Input sanitization
- **CSRF Protection** — Laravel default
- **Role-Based Access (Spatie)** — `super_admin`, `admin`, and `user` roles
- **Permission-Based Access** — Granular permissions (e.g., `manage_language`)
- **Subscription Middleware** — Block features for expired subscriptions
- **Fresh Install Middleware** — Redirect during initial setup
- **Custom Domain Check Middleware** — Resolve VCard/store from custom domains
- **VCard Edit Middleware** — Ensure users can only edit their own VCards
- **VCard Enquiry Middleware** — Ensure users can only view their own enquiries
- **VCard/Store Analytics Middleware** — Access control on analytics pages
- **Google reCAPTCHA v2/v3** — Spam protection on registration forms

### 20.4 SEO & Performance
- **Sitemap Generation** — Automated XML sitemap (daily cron + on-demand)
- **Meta Tags** — Per-page SEO configuration
- **Google Analytics** — Platform and VCard level
- **QR Code Generation** — SimpleSoftwareIO QR Code library
- **Livewire Datatables** — 63 Livewire table components for efficient server-side data tables

### 20.5 Data Export
- **Contacts PDF Export** — Download VCard contacts as PDF
- **Contacts XLS Export** — Download VCard contacts as spreadsheet
- **NFC Card PDF** — Export NFC card details
- **Contact Request Export** — Export contact requests to Excel (`ContactRequestExport`)

### 20.6 Deployment
- **Docker Support** — Dockerfile and docker-compose for containerized deployment
- **Render.com Compatible** — Configured for Render hosting with PostgreSQL
- **Database Migrations** — Full migration suite with PostgreSQL compatibility
- **Database Upgrade** — Admin panel button to run migrations without CLI

---

## Summary Statistics

| Category | Count |
|----------|-------|
| VCard Templates | 30+ |
| Payment Gateways | 10 |
| Models | 94 |
| Web Controllers | 74+ |
| API Controllers | 59+ |
| Livewire Components | 63 |
| Mail Classes | 24 |
| Middleware | 24 |
| Repositories | 35 |
| Database Migrations | 100+ |
| Supported Languages | Unlimited (admin-managed) |
| User Roles | 2 (Super Admin, Admin/Tenant) |

📋 Highlights
Section	Key Features
🔐 Auth & Security	Login, Registration, Social OAuth, 2FA, Impersonation, XSS protection
🌐 Public Frontend	Landing page, Blog, FAQs, Pricing, Custom CMS pages, Legal pages
👤 Admin (Tenant)	Dashboard, VCard CRUD, Services/Products/Galleries/Testimonials, Appointments, Enquiries, Contacts, Orders, Settings, E-Cards, NFC, Storage
🛡️ Super Admin	User/Plan/Subscription management, Content CMS, Coupon codes, NFC types, Affiliate system, Domains, Email tools, Location data
📇 VCard System	30+ templates, 20+ content modules per VCard (services, products, blog, gallery, testimonials, iframes, embeds, custom links), QR codes, password protection, custom domains
🛒 WhatsApp Store	Full e-commerce via WhatsApp — products, categories, orders, policies, analytics
💰 Payments	10 payment gateways (Stripe, PayPal, Razorpay, Paystack, Flutterwave, PhonePe, Payfast, Iyzico, Mercado Pago, Manual)
📡 NFC Cards	Order, manage, and print NFC business cards
🤝 Affiliates	Referral tracking, commissions, withdrawals
📊 Analytics	Per-VCard and per-store visit tracking with charts
🌍 Multi-Language	Unlimited languages with translation editor
📱 API	Full REST API (59+ controllers) for mobile app support
The file is organized with a clickable Table of Contents and covers 94 models, 133+ controllers, and 30+ VCard templates.