-- CreateTable
CREATE TABLE "RtcRecord" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "serviceUrl" TEXT NOT NULL,
    "uuid" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "accountID" INTEGER NOT NULL,
    CONSTRAINT "RtcRecord_accountID_fkey" FOREIGN KEY ("accountID") REFERENCES "Account" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
