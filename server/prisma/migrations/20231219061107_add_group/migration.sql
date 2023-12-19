/*
  Warnings:

  - You are about to drop the column `accountID` on the `Message` table. All the data in the column will be lost.

*/
-- CreateTable
CREATE TABLE "Group" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "accountID" INTEGER NOT NULL,
    "signPubkey" TEXT NOT NULL,
    "agentSecret" BLOB NOT NULL,
    "portableConversation" BLOB NOT NULL,
    CONSTRAINT "Group_accountID_fkey" FOREIGN KEY ("accountID") REFERENCES "Account" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "GroupMembers" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "groupID" INTEGER NOT NULL,
    "signPubkey" TEXT NOT NULL,
    "snapshot" BLOB NOT NULL,
    CONSTRAINT "GroupMembers_groupID_fkey" FOREIGN KEY ("groupID") REFERENCES "Group" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "_AccountToMessage" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,
    CONSTRAINT "_AccountToMessage_A_fkey" FOREIGN KEY ("A") REFERENCES "Account" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_AccountToMessage_B_fkey" FOREIGN KEY ("B") REFERENCES "Message" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Message" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "signature" BLOB NOT NULL,
    "buffer" BLOB NOT NULL,
    "groupID" INTEGER,
    CONSTRAINT "Message_groupID_fkey" FOREIGN KEY ("groupID") REFERENCES "Group" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Message" ("buffer", "id", "signature") SELECT "buffer", "id", "signature" FROM "Message";
DROP TABLE "Message";
ALTER TABLE "new_Message" RENAME TO "Message";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;

-- CreateIndex
CREATE UNIQUE INDEX "_AccountToMessage_AB_unique" ON "_AccountToMessage"("A", "B");

-- CreateIndex
CREATE INDEX "_AccountToMessage_B_index" ON "_AccountToMessage"("B");
