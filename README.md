# Hairitege

## 📌 Project Overview

Hairitege is a web application that empowers stylists to guide clients on their healthy hair journey through curated product recommendations, personalized libraries, and easy-to-access client profiles.

---

## ✨ Features

* Secure stylist & client authentication
* Stylist dashboard to manage clients
* Client product libraries with personalized recommendations
* Notes and usage tips for each product
* Easy sharing of client vaults
* Organized product catalog

---

## 🚀 Setup & Installation

Follow these steps to run the project locally:

1. **Clone the Repository**

   ```bash
   git clone https://github.com/Sabreenasal/hairitege.git
   cd hairitege
   ```

2. **Install Dependencies**

   ```bash
   bundle install
   npm install
   ```

3. **Set Up Database**

   ```bash
   rails db:create db:migrate db:seed
   ```

4. **Start the Application**

   ```bash
   bin/dev
   ```

   App runs at [http://localhost:3000](http://localhost:3000)

---

## ⚙️ Configuration

Before running the app, you need to set up some basic settings called **environment variables**. These tell the app how to connect to your database and keep secrets safe.

1. In the root of your project, create a file called `.env`.

2. Add the following lines to `.env`:

```env
DATABASE_URL=postgres://localhost/hairitege_dev
SECRET_KEY_BASE=your-secret-key
RAILS_ENV=development

---

## 🤝 Contribution Guidelines

We welcome contributions! Please follow these standards:

* **Branch Naming**

  * `feature/your-feature-name`
  * `fix/your-bug-name`

* **Coding Conventions**

  * Follow Rails & Ruby style guides
  * Keep commits small and meaningful

* **Pull Requests**

  * Open PRs against `main` branch
  * Write clear descriptions of changes

* **Commit Messages**

  * Use concise, descriptive commits (e.g., `Add client dashboard view`)

---

## 📊 Entity Relationship Diagram (ERD)

```
Users (Stylists & Clients)
├─ id
├─ name
├─ email
├─ password
└─ role ("stylist" or "client")

Recommendations
├─ id
├─ stylist_id → Users(id)
├─ client_id → Users(id)
├─ product_id → Products(id)
└─ notes

Products
├─ id
├─ name
├─ brand
└─ description
```

*(Add an image version of my ERD at `/docs/erd.png` and embed it with:)*

```markdown
![ERD](docs/erd.png)
```

---

## 🛠️ Troubleshooting & FAQs

**Q: I ran migrations but the database isn’t working.**
A: Try resetting:

```bash
rails db:drop db:create db:migrate db:seed
```

**Q: I can’t log in after signing up.**
A: Ensure your `role` (`stylist` or `client`) is set correctly in the database.

**Q: Stylesheets or JS aren’t loading.**
A: Run `bin/dev` instead of `rails server` to ensure assets are compiled.

---

## 🖼️ Visual Aids

* Dashboard screenshot (`/docs/screenshots/dashboard.png`)
* Client vault screenshot (`/docs/screenshots/client_vault.png`)


---

## 📡 API Documentation (Optional)

If you expose endpoints, document them here:

### Authentication

**POST** `/api/v1/login`
Request:

```json
{ "email": "user@example.com", "password": "password" }
```

Response:

```json
{ "token": "jwt-token" }
```

### Get Client Recommendations

**GET** `/api/v1/clients/:id/recommendations`
Response:

```json
[
  {
    "product": "SheaMoisture Shampoo",
    "notes": "Use twice a week"
  }
]
```

---

## 📛 Naming

Repository name: **hairitege** ✅ 
---

## 📄 License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.(Placeholder example)
