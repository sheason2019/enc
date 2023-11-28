export interface IPullOperation {
  [T: string]: number[];
}

export interface IPushOperation {
  clientId: string;
  clock: number;
  data: string;
}

export interface IOperationDiff {
  push: IPushOperation[];
  pull: IPullOperation;
}
