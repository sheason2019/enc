-- CreateTable
CREATE TABLE "Message" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "signature" BLOB NOT NULL,
    "buffer" BLOB NOT NULL,
    "accountID" INTEGER,
    CONSTRAINT "Message_accountID_fkey" FOREIGN KEY ("accountID") REFERENCES "Account" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
