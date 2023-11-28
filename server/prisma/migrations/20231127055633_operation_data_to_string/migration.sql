-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Operation" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "clientId" TEXT NOT NULL,
    "clock" INTEGER NOT NULL,
    "data" TEXT NOT NULL,
    "accountID" INTEGER NOT NULL,
    CONSTRAINT "Operation_accountID_fkey" FOREIGN KEY ("accountID") REFERENCES "Account" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Operation" ("accountID", "clientId", "clock", "data", "id") SELECT "accountID", "clientId", "clock", "data", "id" FROM "Operation";
DROP TABLE "Operation";
ALTER TABLE "new_Operation" RENAME TO "Operation";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
