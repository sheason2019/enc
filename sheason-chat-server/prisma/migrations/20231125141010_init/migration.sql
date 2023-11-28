-- CreateTable
CREATE TABLE "Account" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "ecdhPubkey" TEXT NOT NULL,
    "signPubkey" TEXT NOT NULL,
    "snapshot" BLOB NOT NULL
);

-- CreateTable
CREATE TABLE "Operation" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "clientId" TEXT NOT NULL,
    "clock" INTEGER NOT NULL,
    "cipherData" BLOB NOT NULL,
    "nonce" BLOB NOT NULL,
    "mac" BLOB NOT NULL,
    "accountID" INTEGER NOT NULL,
    CONSTRAINT "Operation_accountID_fkey" FOREIGN KEY ("accountID") REFERENCES "Account" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
