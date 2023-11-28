/*
  Warnings:

  - You are about to drop the column `cipherData` on the `Operation` table. All the data in the column will be lost.
  - You are about to drop the column `mac` on the `Operation` table. All the data in the column will be lost.
  - You are about to drop the column `nonce` on the `Operation` table. All the data in the column will be lost.
  - Added the required column `data` to the `Operation` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Operation" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "clientId" TEXT NOT NULL,
    "clock" INTEGER NOT NULL,
    "data" BLOB NOT NULL,
    "accountID" INTEGER NOT NULL,
    CONSTRAINT "Operation_accountID_fkey" FOREIGN KEY ("accountID") REFERENCES "Account" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Operation" ("accountID", "clientId", "clock", "id") SELECT "accountID", "clientId", "clock", "id" FROM "Operation";
DROP TABLE "Operation";
ALTER TABLE "new_Operation" RENAME TO "Operation";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
