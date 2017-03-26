import { BitChessPage } from './app.po';

describe('bit-chess App', () => {
  let page: BitChessPage;

  beforeEach(() => {
    page = new BitChessPage();
  });

  it('should display message saying app works', () => {
    page.navigateTo();
    expect(page.getParagraphText()).toEqual('app works!');
  });
});
