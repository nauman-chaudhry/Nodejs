CREATE TABLE "users" (
  "user_id" int PRIMARY KEY,
  "role_id" int,
  "first_name" varchar,
  "last_name" varchar,
  "email" varchar,
  "password_hash" varchar,
  "phone" varchar,
  "is_verified" boolean,
  "created_at" datetime,
  "updated_at" datetime
);

CREATE TABLE "roles" (
  "role_id" int PRIMARY KEY,
  "role_name" varchar,
  "description" text
);

CREATE TABLE "permissions" (
  "permission_id" int PRIMARY KEY,
  "permission_name" varchar,
  "description" text
);

CREATE TABLE "role_permissions" (
  "role_id" int,
  "permission_id" int
);

CREATE TABLE "businesses" (
  "business_id" int PRIMARY KEY,
  "user_id" int,
  "business_name" varchar,
  "description" text,
  "logo_url" varchar,
  "website" varchar,
  "address" varchar,
  "city" varchar,
  "country" varchar,
  "tax_id" varchar,
  "created_at" datetime
);

CREATE TABLE "categories" (
  "category_id" int PRIMARY KEY,
  "category_name" varchar,
  "description" text
);

CREATE TABLE "events" (
  "event_id" int PRIMARY KEY,
  "business_id" int,
  "category_id" int,
  "event_name" varchar,
  "description" text,
  "venue" varchar,
  "city" varchar,
  "country" varchar,
  "start_date" datetime,
  "end_date" datetime,
  "timezone" varchar,
  "cover_image" varchar,
  "status" varchar,
  "created_at" datetime
);

CREATE TABLE "event_media" (
  "media_id" int PRIMARY KEY,
  "event_id" int,
  "media_url" varchar,
  "media_type" varchar,
  "uploaded_at" datetime
);

CREATE TABLE "tickets" (
  "ticket_id" int PRIMARY KEY,
  "event_id" int,
  "ticket_name" varchar,
  "ticket_type" varchar,
  "price" decimal,
  "quantity_available" int,
  "quantity_sold" int,
  "service_fee" decimal,
  "donation_allowed" boolean,
  "created_at" datetime
);

CREATE TABLE "orders" (
  "order_id" int PRIMARY KEY,
  "user_id" int,
  "event_id" int,
  "total_amount" decimal,
  "payment_status" varchar,
  "payment_id" int,
  "invoice_id" int,
  "created_at" datetime
);

CREATE TABLE "order_items" (
  "order_item_id" int PRIMARY KEY,
  "order_id" int,
  "ticket_id" int,
  "quantity" int,
  "unit_price" decimal,
  "subtotal" decimal
);

CREATE TABLE "payments" (
  "payment_id" int PRIMARY KEY,
  "order_id" int,
  "payment_method" varchar,
  "transaction_ref" varchar,
  "amount" decimal,
  "status" varchar,
  "payment_date" datetime
);

CREATE TABLE "invoices" (
  "invoice_id" int PRIMARY KEY,
  "order_id" int,
  "invoice_number" varchar,
  "amount_due" decimal,
  "amount_paid" decimal,
  "issue_date" datetime,
  "due_date" datetime,
  "status" varchar
);

CREATE TABLE "payouts" (
  "payout_id" int PRIMARY KEY,
  "business_id" int,
  "amount" decimal,
  "fee" decimal,
  "transfer_ref" varchar,
  "status" varchar,
  "payout_date" datetime
);

CREATE TABLE "donations" (
  "donation_id" int PRIMARY KEY,
  "user_id" int,
  "event_id" int,
  "amount" decimal,
  "payment_id" int,
  "donation_date" datetime
);

CREATE TABLE "followers" (
  "follower_id" int PRIMARY KEY,
  "user_id" int,
  "business_id" int,
  "created_at" datetime
);

CREATE TABLE "email_campaigns" (
  "campaign_id" int PRIMARY KEY,
  "business_id" int,
  "title" varchar,
  "subject" varchar,
  "body" text,
  "recipient_list" text,
  "status" varchar,
  "created_at" datetime
);

CREATE TABLE "refunds" (
  "refund_id" int PRIMARY KEY,
  "order_id" int,
  "payment_id" int,
  "amount" decimal,
  "reason" text,
  "status" varchar,
  "created_at" datetime
);

CREATE TABLE "bank_accounts" (
  "bank_id" int PRIMARY KEY,
  "business_id" int,
  "account_name" varchar,
  "account_number" varchar,
  "bank_name" varchar,
  "swift_code" varchar,
  "currency" varchar
);

CREATE TABLE "widgets" (
  "widget_id" int PRIMARY KEY,
  "business_id" int,
  "event_id" int,
  "widget_type" varchar,
  "embed_code" text,
  "created_at" datetime
);

CREATE TABLE "integrations" (
  "integration_id" int PRIMARY KEY,
  "business_id" int,
  "integration_name" varchar,
  "api_key" varchar,
  "status" varchar,
  "created_at" datetime
);

CREATE TABLE "reports" (
  "report_id" int PRIMARY KEY,
  "business_id" int,
  "report_type" varchar,
  "generated_at" datetime,
  "data_json" text
);

CREATE TABLE "admin_logs" (
  "log_id" int PRIMARY KEY,
  "admin_id" int,
  "action" varchar,
  "entity_type" varchar,
  "entity_id" int,
  "timestamp" datetime
);

CREATE TABLE "settings" (
  "setting_id" int PRIMARY KEY,
  "scope" varchar,
  "business_id" int,
  "key" varchar,
  "value" text,
  "updated_at" datetime
);

CREATE TABLE "notifications" (
  "notification_id" int PRIMARY KEY,
  "user_id" int,
  "title" varchar,
  "message" text,
  "type" varchar,
  "is_read" boolean,
  "created_at" datetime
);

CREATE TABLE "attendees" (
  "attendee_id" int PRIMARY KEY,
  "user_id" int,
  "event_id" int,
  "ticket_id" int,
  "check_in_status" boolean,
  "check_in_time" datetime,
  "created_at" datetime
);

CREATE TABLE "event_staff" (
  "staff_id" int PRIMARY KEY,
  "event_id" int,
  "user_id" int,
  "role" varchar,
  "assigned_at" datetime
);

CREATE TABLE "sponsors" (
  "sponsor_id" int PRIMARY KEY,
  "event_id" int,
  "sponsor_name" varchar,
  "logo_url" varchar,
  "contact_email" varchar,
  "sponsorship_amount" decimal,
  "sponsorship_type" varchar,
  "created_at" datetime
);

CREATE TABLE "event_schedule" (
  "schedule_id" int PRIMARY KEY,
  "event_id" int,
  "title" varchar,
  "description" text,
  "start_time" datetime,
  "end_time" datetime,
  "speaker_name" varchar,
  "location" varchar,
  "created_at" datetime
);

CREATE TABLE "feedback" (
  "feedback_id" int PRIMARY KEY,
  "user_id" int,
  "event_id" int,
  "rating" int,
  "comment" text,
  "created_at" datetime
);

CREATE TABLE "faqs" (
  "faq_id" int PRIMARY KEY,
  "event_id" int,
  "question" text,
  "answer" text,
  "created_at" datetime,
  "updated_at" datetime
);

CREATE TABLE "event_faqs" (
  "event_faq_id" int PRIMARY KEY,
  "faq_id" int,
  "created_at" datetime
);

CREATE TABLE "messages" (
  "message_id" int PRIMARY KEY,
  "sender_id" int,
  "receiver_id" int,
  "subject" varchar,
  "body" text,
  "status" varchar,
  "created_at" datetime
);

CREATE TABLE "comments" (
  "comment_id" int PRIMARY KEY,
  "user_id" int,
  "event_id" int,
  "parent_comment_id" int,
  "content" text,
  "created_at" datetime
);

CREATE TABLE "support_tickets" (
  "ticket_id" int PRIMARY KEY,
  "user_id" int,
  "subject" varchar,
  "message" text,
  "status" varchar,
  "priority" varchar,
  "created_at" datetime,
  "updated_at" datetime
);

CREATE TABLE "support_responses" (
  "response_id" int PRIMARY KEY,
  "ticket_id" int,
  "responder_id" int,
  "message" text,
  "created_at" datetime
);

CREATE TABLE "event_views" (
  "view_id" int PRIMARY KEY,
  "event_id" int,
  "user_id" int,
  "viewed_at" datetime,
  "ip_address" varchar,
  "device" varchar
);

CREATE TABLE "ticket_scans" (
  "scan_id" int PRIMARY KEY,
  "attendee_id" int,
  "event_id" int,
  "ticket_id" int,
  "scanned_at" datetime,
  "scanner_user_id" int
);

CREATE TABLE "audit_logs" (
  "audit_id" int PRIMARY KEY,
  "user_id" int,
  "entity_type" varchar,
  "entity_id" int,
  "action" varchar,
  "old_value" text,
  "new_value" text,
  "created_at" datetime
);

CREATE TABLE "locations" (
  "location_id" int PRIMARY KEY,
  "event_id" int,
  "address_line1" varchar,
  "address_line2" varchar,
  "city" varchar,
  "state" varchar,
  "postal_code" varchar,
  "country" varchar,
  "latitude" decimal,
  "longitude" decimal
);

CREATE TABLE "add_ons" (
  "add_on_id" int PRIMARY KEY,
  "name" varchar,
  "description" text,
  "price" decimal,
  "available_quantity" int,
  "created_at" datetime
);

CREATE TABLE "event_add_ons" (
  "event_add_on_id" int PRIMARY KEY,
  "event_id" int,
  "add_on_id" int,
  "status" varchar,
  "created_at" datetime
);

CREATE TABLE "order_add_ons" (
  "order_add_on_id" int PRIMARY KEY,
  "order_id" int,
  "add_on_id" int,
  "quantity" int,
  "unit_price" decimal,
  "subtotal" decimal
);

CREATE TABLE "promo_codes" (
  "promo_id" int PRIMARY KEY,
  "event_id" int,
  "code_name" varchar,
  "description" text,
  "discount_type" varchar,
  "discount_value" decimal,
  "ticket_limit" int,
  "usage_limit" int,
  "used_count" int,
  "visibility" varchar,
  "start_time" datetime,
  "end_time" datetime,
  "created_at" datetime
);

CREATE TABLE "promo_code_tickets" (
  "promo_ticket_id" int PRIMARY KEY,
  "promo_id" int,
  "ticket_id" int,
  "add_on_id" int
);

CREATE TABLE "agendas" (
  "agenda_id" int PRIMARY KEY,
  "event_id" int,
  "title" varchar,
  "description" text,
  "start_time" datetime,
  "end_time" datetime,
  "location" varchar,
  "created_at" datetime
);

ALTER TABLE "users" ADD FOREIGN KEY ("role_id") REFERENCES "roles" ("role_id");

ALTER TABLE "role_permissions" ADD FOREIGN KEY ("role_id") REFERENCES "roles" ("role_id");

ALTER TABLE "role_permissions" ADD FOREIGN KEY ("permission_id") REFERENCES "permissions" ("permission_id");

ALTER TABLE "businesses" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("user_id");

ALTER TABLE "events" ADD FOREIGN KEY ("business_id") REFERENCES "businesses" ("business_id");

ALTER TABLE "events" ADD FOREIGN KEY ("category_id") REFERENCES "categories" ("category_id");

ALTER TABLE "event_media" ADD FOREIGN KEY ("event_id") REFERENCES "events" ("event_id");

ALTER TABLE "tickets" ADD FOREIGN KEY ("event_id") REFERENCES "events" ("event_id");

ALTER TABLE "orders" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("user_id");

ALTER TABLE "orders" ADD FOREIGN KEY ("event_id") REFERENCES "events" ("event_id");

ALTER TABLE "order_items" ADD FOREIGN KEY ("order_id") REFERENCES "orders" ("order_id");

ALTER TABLE "order_items" ADD FOREIGN KEY ("ticket_id") REFERENCES "tickets" ("ticket_id");

ALTER TABLE "payments" ADD FOREIGN KEY ("order_id") REFERENCES "orders" ("order_id");

ALTER TABLE "invoices" ADD FOREIGN KEY ("order_id") REFERENCES "orders" ("order_id");

ALTER TABLE "payouts" ADD FOREIGN KEY ("business_id") REFERENCES "businesses" ("business_id");

ALTER TABLE "donations" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("user_id");

ALTER TABLE "donations" ADD FOREIGN KEY ("event_id") REFERENCES "events" ("event_id");

ALTER TABLE "donations" ADD FOREIGN KEY ("payment_id") REFERENCES "payments" ("payment_id");

ALTER TABLE "followers" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("user_id");

ALTER TABLE "followers" ADD FOREIGN KEY ("business_id") REFERENCES "businesses" ("business_id");

ALTER TABLE "email_campaigns" ADD FOREIGN KEY ("business_id") REFERENCES "businesses" ("business_id");

ALTER TABLE "refunds" ADD FOREIGN KEY ("order_id") REFERENCES "orders" ("order_id");

ALTER TABLE "refunds" ADD FOREIGN KEY ("payment_id") REFERENCES "payments" ("payment_id");

ALTER TABLE "bank_accounts" ADD FOREIGN KEY ("business_id") REFERENCES "businesses" ("business_id");

ALTER TABLE "widgets" ADD FOREIGN KEY ("business_id") REFERENCES "businesses" ("business_id");

ALTER TABLE "widgets" ADD FOREIGN KEY ("event_id") REFERENCES "events" ("event_id");

ALTER TABLE "integrations" ADD FOREIGN KEY ("business_id") REFERENCES "businesses" ("business_id");

ALTER TABLE "reports" ADD FOREIGN KEY ("business_id") REFERENCES "businesses" ("business_id");

ALTER TABLE "admin_logs" ADD FOREIGN KEY ("admin_id") REFERENCES "users" ("user_id");

ALTER TABLE "settings" ADD FOREIGN KEY ("business_id") REFERENCES "businesses" ("business_id");

ALTER TABLE "notifications" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("user_id");

ALTER TABLE "attendees" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("user_id");

ALTER TABLE "attendees" ADD FOREIGN KEY ("event_id") REFERENCES "events" ("event_id");

ALTER TABLE "attendees" ADD FOREIGN KEY ("ticket_id") REFERENCES "tickets" ("ticket_id");

ALTER TABLE "event_staff" ADD FOREIGN KEY ("event_id") REFERENCES "events" ("event_id");

ALTER TABLE "event_staff" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("user_id");

ALTER TABLE "sponsors" ADD FOREIGN KEY ("event_id") REFERENCES "events" ("event_id");

ALTER TABLE "event_schedule" ADD FOREIGN KEY ("event_id") REFERENCES "events" ("event_id");

ALTER TABLE "feedback" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("user_id");

ALTER TABLE "feedback" ADD FOREIGN KEY ("event_id") REFERENCES "events" ("event_id");

ALTER TABLE "faqs" ADD FOREIGN KEY ("event_id") REFERENCES "events" ("event_id");

ALTER TABLE "event_faqs" ADD FOREIGN KEY ("faq_id") REFERENCES "faqs" ("faq_id");

ALTER TABLE "messages" ADD FOREIGN KEY ("sender_id") REFERENCES "users" ("user_id");

ALTER TABLE "messages" ADD FOREIGN KEY ("receiver_id") REFERENCES "users" ("user_id");

ALTER TABLE "comments" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("user_id");

ALTER TABLE "comments" ADD FOREIGN KEY ("event_id") REFERENCES "events" ("event_id");

ALTER TABLE "support_tickets" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("user_id");

ALTER TABLE "support_responses" ADD FOREIGN KEY ("ticket_id") REFERENCES "support_tickets" ("ticket_id");

ALTER TABLE "support_responses" ADD FOREIGN KEY ("responder_id") REFERENCES "users" ("user_id");

ALTER TABLE "event_views" ADD FOREIGN KEY ("event_id") REFERENCES "events" ("event_id");

ALTER TABLE "event_views" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("user_id");

ALTER TABLE "ticket_scans" ADD FOREIGN KEY ("attendee_id") REFERENCES "attendees" ("attendee_id");

ALTER TABLE "ticket_scans" ADD FOREIGN KEY ("event_id") REFERENCES "events" ("event_id");

ALTER TABLE "ticket_scans" ADD FOREIGN KEY ("ticket_id") REFERENCES "tickets" ("ticket_id");

ALTER TABLE "audit_logs" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("user_id");

ALTER TABLE "locations" ADD FOREIGN KEY ("event_id") REFERENCES "events" ("event_id");

ALTER TABLE "event_add_ons" ADD FOREIGN KEY ("event_id") REFERENCES "events" ("event_id");

ALTER TABLE "event_add_ons" ADD FOREIGN KEY ("add_on_id") REFERENCES "add_ons" ("add_on_id");

ALTER TABLE "order_add_ons" ADD FOREIGN KEY ("order_id") REFERENCES "orders" ("order_id");

ALTER TABLE "order_add_ons" ADD FOREIGN KEY ("add_on_id") REFERENCES "add_ons" ("add_on_id");

ALTER TABLE "promo_codes" ADD FOREIGN KEY ("event_id") REFERENCES "events" ("event_id");

ALTER TABLE "promo_code_tickets" ADD FOREIGN KEY ("promo_id") REFERENCES "promo_codes" ("promo_id");

ALTER TABLE "promo_code_tickets" ADD FOREIGN KEY ("ticket_id") REFERENCES "tickets" ("ticket_id");

ALTER TABLE "promo_code_tickets" ADD FOREIGN KEY ("add_on_id") REFERENCES "add_ons" ("add_on_id");

ALTER TABLE "agendas" ADD FOREIGN KEY ("event_id") REFERENCES "events" ("event_id");
