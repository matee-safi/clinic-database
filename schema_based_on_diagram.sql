CREATE TABLE patients (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    date_of_birth date NOT NULL
);
CREATE TABLE treatments (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    type VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL
);
CREATE TABLE medical_histories (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    admitted_at TIMESTAMP NOT NULL,
    patient_id INT,
    status VARCHAR(255) NOT NULL
);
CREATE TABLE invoices (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    total_amount DECIMAL(10,2) NOT NULL,
    generated_at TIMESTAMP NOT NULL,
    payed_at TIMESTAMP,
    medical_history_id INT
);
CREATE TABLE invoice_items (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    invoice_id INT,
    treatment_id INT
);
ALTER TABLE medical_histories ADD CONSTRAINT fk_medical_histories_patients FOREIGN KEY (patient_id) REFERENCES patients (id);
ALTER TABLE invoices ADD CONSTRAINT fk_invoices_medical_histories FOREIGN KEY (medical_history_id) REFERENCES medical_histories (id);
ALTER TABLE invoice_items ADD CONSTRAINT fk_invoice_items_invoices FOREIGN KEY (invoice_id) REFERENCES invoices (id);
ALTER TABLE invoice_items ADD CONSTRAINT fk_invoice_items_treatments FOREIGN KEY (treatment_id) REFERENCES treatments (id);
CREATE TABLE medical_histories_treatments (
    medical_history_id INT,
    treatment_id INT,
    PRIMARY KEY (medical_history_id, treatment_id)
);